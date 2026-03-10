import os

def secure_random_int(start, end):
    """Generate a random integer in the range [start, end] using os.urandom."""
    range_size = end - start + 1
    while True:
        # Generate a random 4-byte integer
        random_bytes = os.urandom(4)
        random_int = int.from_bytes(random_bytes, byteorder="big")
        
        # Ensure the number fits in the desired range
        if random_int < (2**32 // range_size) * range_size:
            return start + (random_int % range_size)

nrs = []
for _ in range(5):
    n = secure_random_int(1, 40)
    print('.', end='')
    while n in nrs:
        print('+', end='')
        n = secure_random_int(1, 40)
        print('.', end='')
    nrs.append(n)
print()
print(nrs)
