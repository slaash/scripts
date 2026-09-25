import requests
from bs4 import BeautifulSoup
import sqlite3
import sys
from requests.adapters import HTTPAdapter
from urllib3.util.retry import Retry

URL = "https://www.loto49.ro/arhiva-loto49.php"
DB_FILE = "loto49.db"

# Setup robust session with retries
def get_session():
    session = requests.Session()
    retries = Retry(total=5, backoff_factor=1, status_forcelist=[502, 503, 504])
    session.mount('https://', HTTPAdapter(max_retries=retries))
    return session

def init_db():
    conn = sqlite3.connect(DB_FILE)
    cursor = conn.cursor()
    cursor.execute('''
        CREATE TABLE IF NOT EXISTS draws (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            date TEXT,
            n1 INTEGER,
            n2 INTEGER,
            n3 INTEGER,
            n4 INTEGER,
            n5 INTEGER,
            n6 INTEGER,
            UNIQUE(date, n1, n2, n3, n4, n5, n6)
        )
    ''')
    conn.commit()
    return conn

def scrape_page(session, url):
    print(f"Fetching data from {url}...")
    try:
        response = session.get(url, timeout=15)
        response.raise_for_status()
    except requests.RequestException as e:
        print(f"Error fetching page {url}: {e}")
        return [], None

    soup = BeautifulSoup(response.text, 'html.parser')
    # Use a more specific selector if possible, or fallback to first table
    table = soup.find('table')
    if not table:
        print("Could not find the results table.")
        return [], None

    rows = table.find_all('tr')
    draws = []

    for row in rows:
        cols = row.find_all('td')
        if len(cols) == 7:  # Date + 6 numbers
            try:
                date = cols[0].text.strip()
                nums = [int(cols[i].text.strip()) for i in range(1, 7)]
                
                # Validation: ensure numbers are 1-49
                if all(1 <= n <= 49 for n in nums):
                    draws.append((date, *nums))
            except ValueError:
                continue
    
    # Try to find a "next" page link (simple example)
    next_page = None
    next_link = soup.find('a', string='Next') # Adjust selector based on actual site
    if next_link and next_link.get('href'):
        next_page = next_link.get('href')
    
    return draws, next_page

def update_db(conn, draws):
    cursor = conn.cursor()
    inserted = 0
    skipped = 0
    
    sql = 'INSERT OR IGNORE INTO draws (date, n1, n2, n3, n4, n5, n6) VALUES (?, ?, ?, ?, ?, ?, ?)'
    
    for draw in draws:
        cursor.execute(sql, draw)
        if cursor.rowcount > 0:
            inserted += 1
        else:
            skipped += 1
            
    conn.commit()
    return inserted, skipped

def main():
    conn = init_db()
    session = get_session()
    
    current_url = URL
    all_draws = []
    
    while current_url:
        page_draws, next_url = scrape_page(session, current_url)
        all_draws.extend(page_draws)
        
        # Handle potential infinite loops
        if next_url == current_url:
            break
        current_url = next_url
        
    if not all_draws:
        print("No draws found to process.")
        conn.close()
        return

    print(f"Found {len(all_draws)} total draws in the archive.")
    inserted, skipped = update_db(conn, all_draws)
    
    print(f"Update complete: {inserted} new records added, {skipped} skipped (already existed).")
    
    cursor = conn.cursor()
    cursor.execute('SELECT COUNT(*) FROM draws')
    total = cursor.fetchone()[0]
    print(f"Total records in database: {total}")
    
    conn.close()

if __name__ == "__main__":
    main()
