import math

def solve():
    # Constants from previous run
    pool_size = 27
    winning_in_pool = 5
    
    # Total combinations of 6 from 27
    T = math.comb(pool_size, 6)
    
    # Winning combinations (3, 4, 5, or 6 matches)
    # m = 5 winning numbers, k-m = 22 non-winning numbers in pool
    w3 = math.comb(5, 3) * math.comb(22, 3)
    w4 = math.comb(5, 4) * math.comb(22, 2)
    w5 = math.comb(5, 5) * math.comb(22, 1)
    w6 = math.comb(5, 6) * math.comb(22, 0)
    
    W = w3 + w4 + w5 + w6
    p_win = W / T
    
    # Probability of winning at least once in N trials: 1 - (1 - p_win)^N
    # We want 1 - (1 - p_win)^N >= 0.30
    # (1 - p_win)^N <= 0.70
    # N * log(1 - p_win) <= log(0.70)
    # N >= log(0.70) / log(1 - p_win)
    
    N = math.log(0.70) / math.log(1 - p_win)
    
    print(f"Total pool combinations: {T}")
    print(f"Winning combinations (3+): {W}")
    print(f"Prob of winning per variant: {p_win:.6f}")
    print(f"Required variants for 30% chance: {math.ceil(N)}")

if __name__ == "__main__":
    solve()
