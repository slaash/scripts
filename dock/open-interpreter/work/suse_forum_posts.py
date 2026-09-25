import requests
from bs4 import BeautifulSoup
import urllib.parse

# Target URL
url = "https://forums.suse.com/c/k3s-k3os-k3d/19"

# Headers to avoid bot detection
headers = {
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36",
    "Accept-Language": "en-US,en;q=0.9"
}

def fetch_posts(url, limit=10):
    try:
        # Fetch HTML with proper headers
        response = requests.get(url, headers=headers, timeout=15)
        response.raise_for_status()
        
        soup = BeautifulSoup(response.text, 'html.parser')
        
        posts = []
        
        # Look for post/listing elements
        containers = soup.find_all('div', class_='forum-thread-list-item')
        if not containers:
            containers = soup.select_many('tr.topic')
        
        post_count = 0
        for container in containers[:limit]:
            post_count += 1
            
            # Extract title (link text)
            title_elem = container.find('a', class_='discussion-thread-link') or \
                         container.find('a', href=True) or \
                         container.find(class_='thread-title')
            
            if title_elem:
                title = title_elem.get_text(strip=True)[:100]  # Limit length
            else:
                continue
            
            # Extract link
            link = title_elem['href'] if title_elem else f"{url}/{post_count}"
            link = urllib.parse.urljoin(url, link)
            
            # Extract date/timestamp if available
            date = "Unknown"
            date_elem = container.find(class_='thread-date') or \
                        container.select_one('[data-timestamp]')
            if date_elem:
                if date_elem.get('datetime'):
                    date = date_elem['datetime'][:20]
                else:
                    # Try get_text fallback
                    date = str(date_elem)[:20]
            
            posts.append({
                'title': title,
                'link': link,
                'date': date
            })
        
        return posts
        
    except requests.RequestException as e:
        print(f"Error fetching {url}: {e}")
        return []

def main():
    print("=" * 80)
    print("SUSE Forum Posts - Latest 10 from k3s-k3os-k3d")
    print("=" * 80)
    
    posts = fetch_posts(url, limit=10)
    
    if not posts:
        print("No posts found. The forum may have changed its structure.")
        return
    
    for i, post in enumerate(posts, 1):
        print(f"\n[{i}] {post['title']}")
        print(f"   Link: {post['link']}")
        if post['date']:
            print(f"   Date: {post['date']}")

if __name__ == "__main__":
    main()
