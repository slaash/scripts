import math

def solve():
    pool_size = 27
    winning_in_pool = 5
    
    T = math.comb(pool_size, 6)
    # Exactly 5 numbers: we must pick all 5 winning ones and 1 from the 22 non-winning ones
    W5 = math.comb(winning_in_pool, 5) * math.comb(pool_size - winning_in_pool, 1)
    
    p_5 = W5 / T
    
    # 1 - (1 - p_5)^N >= 0.30
    N = math.log(0.70) / math.log(1 - p_5)
    
    print(f"Prob of 5/6 per variant: {p_5:.10f}")
    print(f"Required variants for 30% chance: {math.ceil(N)}")

if __name__ == "__main__":
    solve()
