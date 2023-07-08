import pprint, secrets

diceArt = { 1: "9", 2: "10", 3: "J", 4: "Q", 5: "K", 6: "A" }

pp = pprint.PrettyPrinter(indent=4)

def genHand(n):
    hand = []
    for d in range(0, n):
        r = secrets.randbelow(6) + 1
        hand.append(r)
    return hand

def showHand(hand):
    artHand = []
    for d in hand:
        artHand.append(diceArt[d])
    c = 1
    for a in artHand:
        print("{}) {}".format(c, a), end='\t')
        c += 1
    print('')

for p in range (0,2):
    hand = genHand(5)
    for h in range(0, 3):
        print("Player {}, hand {}".format(p+1, h+1))
        showHand(hand)
        range(1, 5)
        diceToKeep = []
        choice = input("  What to keep (comma separated list of dice (1-5) or null for exit)? ")
        choice = choice.replace(' ', '')
        opts = choice.split(',')
        if len(opts) == 0 or opts[0]== '':
            break
        for opt in opts:
            diceToKeep.append(hand[int(opt)-1])
        shortHand = genHand(5 - len(diceToKeep))
        hand = shortHand + diceToKeep
    print("Player {}, final hand".format(p+1))
    showHand(hand)
