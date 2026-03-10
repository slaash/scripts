import random
random.seed()
nrs=[]
for i in range(5):
    n=random.randint(1,45)
    print('.', end='')
    while n in nrs:
        print('+', end='')
        n=random.randint(1,45)
        print('.', end='')
    nrs.append(n)
print()
print(nrs)

