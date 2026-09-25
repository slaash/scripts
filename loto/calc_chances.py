import sqlite3
from collections import Counter
import math

DB_FILE = "loto49.db"

def nCr(n, r):
    if r < 0 or r > n:
        return 0
    return math.comb(n, r)

def analyze_last_draw():
    conn = sqlite3.connect(DB_FILE)
    cursor = conn.cursor()
    
    # Get all draws ordered by date
    cursor.execute('SELECT date, n1, n2, n3, n4, n5, n6 FROM draws ORDER BY date ASC')
    rows = cursor.fetchall()
    conn.close()
    
    if len(rows) < 2:
        print("Not enough data to analyze trends.")
        return

    # The last draw is the target
    last_draw_row = rows[-1]
    last_draw_nums = set(last_draw_row[1:])
    last_draw_date = last_draw_row[0]
    
    # History is everything except the last draw
    history = rows[:-1]
    
    # Trend analysis on history
    mid = len(history) // 2
    first_half = []
    for row in history[:mid]:
        first_half.extend(row[1:])
    
    second_half = []
    for row in history[mid:]:
        second_half.extend(row[1:])
        
    first_counts = Counter(first_half)
    second_counts = Counter(second_half)
    
    pool = []
    for n in range(1, 50):
        f1 = first_counts[n]
        f2 = second_counts[n]
        if f2 >= f1: # Ascending or Stable
            pool.append(n)
    
    pool_size = len(pool)
    winning_in_pool = last_draw_nums.intersection(set(pool))
    m = len(winning_in_pool)
    
    print(f"Last Draw Date: {last_draw_date}")
    print(f"Last Draw Numbers: {sorted(list(last_draw_nums))}")
    print(f"Pool size (Ascending + Stable): {pool_size}")
    print(f"Winning numbers in pool: {sorted(list(winning_in_pool))} ({m}/6)")
    
    # Probability of picking x winning numbers from the pool
    # P(X=x) = [C(m, x) * C(k-m, 6-x)] / C(k, 6)
    k = pool_size
    total_combinations = nCr(k, 6)
    
    print("\nChances of picking from the pool:")
    for x in range(6, 2, -1):
        combos = nCr(m, x) * nCr(k - m, 6 - x)
        prob = combos / total_combinations if total_combinations > 0 else 0
        print(f"{x}/6: {prob:.8f} ({combos} combinations)")

if __name__ == "__main__":
    analyze_last_draw()
