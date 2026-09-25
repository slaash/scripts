import sqlite3
from collections import Counter, defaultdict

DB_FILE = "loto49.db"

def analyze_loto():
    conn = sqlite3.connect(DB_FILE)
    cursor = conn.cursor()
    
    # Get all draws ordered by date
    cursor.execute('SELECT date, n1, n2, n3, n4, n5, n6 FROM draws ORDER BY date ASC')
    rows = cursor.fetchall()
    conn.close()
    
    if not rows:
        print("No data found in database.")
        return

    all_numbers = []
    for row in rows:
        all_numbers.extend(row[1:])

    # Overall frequency
    counts = Counter(all_numbers)
    
    # Group by month for trend analysis
    month_data = defaultdict(list)
    draws_per_month = defaultdict(int)
    for row in rows:
        month = row[0][:7] # YYYY-MM
        month_data[month].extend(row[1:])
        draws_per_month[month] += 1
    
    sorted_months = sorted(month_data.keys())
    if len(sorted_months) < 2:
        print("Not enough monthly data for trend analysis.")
        return

    recent_month = sorted_months[-1]
    historical_months = sorted_months[:-1]
    
    # Calculate counts per number
    recent_counts = Counter(month_data[recent_month])
    history_counts = Counter()
    for m in historical_months:
        history_counts.update(month_data[m])
        
    len_recent = draws_per_month[recent_month]
    len_history = sum(draws_per_month[m] for m in historical_months)
    
    # Analyze each number from 1 to 49
    stats = []
    for n in range(1, 50):
        freq = counts[n]
        f_recent = recent_counts[n]
        f_history = history_counts[n]
        
        # Calculate frequency per draw (normalized)
        f_recent_norm = f_recent / len_recent if len_recent > 0 else 0
        f_history_norm = f_history / len_history if len_history > 0 else 0
        
        if f_recent_norm > f_history_norm:
            trend = "Ascending"
        elif f_recent_norm < f_history_norm:
            trend = "Descending"
        else:
            trend = "Stable"
            
        stats.append({
            'number': n,
            'frequency': freq,
            'trend': trend
        })
    
    # Sort: Rank (highest frequency first), then trend (Ascending -> Stable -> Descending)
    trend_priority = {'Ascending': 0, 'Stable': 1, 'Descending': 2}
    stats.sort(key=lambda x: (-x['frequency'], trend_priority[x['trend']], x['number']))
    
    print(f"{'Rank':<5} {'Num':<5} {'Freq':<6} {'Trend':<12}")
    print("-" * 30)
    for i, s in enumerate(stats, 1):
        print(f"{i:<5} {s['number']:<5} {s['frequency']:<6} {s['trend']:<12}")

if __name__ == "__main__":
    analyze_loto()
