import argparse, pprint, secrets, time

diceArt   = { 1: "9",       2: "10",     3: "J",       4: "Q",      5: "K",     6: "A"       }
diceColor = { 1: "\033[1m",   2: "\033[91m", 3: "\033[1m",   4: "\033[94m", 5: "\033[91m", 6: "\033[1m"   }
RESET = "\033[0m"
PLAYER_COLORS = ["\033[92m", "\033[93m", "\033[95m", "\033[96m", "\033[91m", "\033[94m"]

pp = pprint.PrettyPrinter(indent=4)

def genHand(n):
    hand = []
    for d in range(0, n):
        r = secrets.randbelow(6) + 1
        hand.append(r)
    return hand

def dieLines(value):
    color = diceColor[value]
    label = diceArt[value].center(2)
    return [
        f"{color}+----+{RESET}",
        f"{color}| {label} |{RESET}",
        f"{color}+----+{RESET}",
    ]

W = 38

def divider(char, label=""):
    if label:
        side = (W - len(label) - 2) // 2
        print(char * side + " " + label + " " + char * (W - side - len(label) - 2))
    else:
        print(char * W)

def showHand(hand, keeps_str=None):
    all_lines = [dieLines(d) for d in hand]
    for row in range(3):
        print("  ".join(lines[row] for lines in all_lines))
    print("  ".join(str(i + 1).center(6) for i in range(len(hand))))
    indices = comboIndices(hand)
    combo = "  {} ({})".format(handName(hand), ','.join(str(i) for i in indices))
    if keeps_str is not None:
        print("{}  →  keeps: {}".format(combo, keeps_str))
    else:
        print(combo)
    print()

def rankHand(hand):
    counts = {}
    for d in hand:
        counts[d] = counts.get(d, 0) + 1
    freq = sorted(counts.values(), reverse=True)
    is_straight = len(counts) == 5 and (max(hand) - min(hand) == 4)
    # Tiebreak: dice sorted by (count desc, value desc), flattened
    groups = sorted(counts.items(), key=lambda x: (x[1], x[0]), reverse=True)
    tiebreak = [v for v, c in groups for _ in range(c)]
    if freq == [5]:           return (8, tiebreak)
    if freq == [4, 1]:        return (7, tiebreak)
    if freq == [3, 2]:        return (6, tiebreak)
    if is_straight:           return (5, tiebreak)
    if freq == [3, 1, 1]:     return (4, tiebreak)
    if freq == [2, 2, 1]:     return (3, tiebreak)
    if freq == [2, 1, 1, 1]:  return (2, tiebreak)
    return (1, tiebreak)

def handName(hand):
    names = {8: "five of a kind", 7: "four of a kind", 6: "full house",
             5: "straight",       4: "three of a kind", 3: "two pair",
             2: "one pair",       1: "high card"}
    return names[rankHand(hand)[0]]

def comboIndices(hand):
    counts = {}
    for d in hand:
        counts[d] = counts.get(d, 0) + 1
    freq = sorted(counts.values(), reverse=True)
    is_straight = len(counts) == 5 and (max(hand) - min(hand) == 4)
    if freq == [5] or freq == [3, 2] or is_straight:
        return list(range(1, 6))
    if freq == [4, 1]:
        val = next(v for v, c in counts.items() if c == 4)
        return [i+1 for i, d in enumerate(hand) if d == val]
    if freq == [3, 1, 1]:
        val = next(v for v, c in counts.items() if c == 3)
        return [i+1 for i, d in enumerate(hand) if d == val]
    if freq == [2, 2, 1]:
        vals = {v for v, c in counts.items() if c == 2}
        return [i+1 for i, d in enumerate(hand) if d in vals]
    if freq == [2, 1, 1, 1]:
        val = next(v for v, c in counts.items() if c == 2)
        return [i+1 for i, d in enumerate(hand) if d == val]
    max_val = max(hand)
    return [next(i+1 for i, d in enumerate(hand) if d == max_val)]

def compareHands(hands):
    ranks = [rankHand(h) for h in hands]
    best = max(ranks)
    return [i for i, r in enumerate(ranks) if r == best]

def computerKeep(hand):
    counts = {}
    for d in hand:
        counts[d] = counts.get(d, 0) + 1
    keep_vals = {v for v, c in counts.items() if c > 1}
    if keep_vals:
        return [i for i, d in enumerate(hand) if d in keep_vals]
    else:
        sorted_indices = sorted(range(len(hand)), key=lambda i: hand[i], reverse=True)
        return sorted_indices[:2]

parser = argparse.ArgumentParser(description="Poker dice game")
parser.add_argument("--players", type=int, default=2, help="Number of players")
parser.add_argument("--no-human", action="store_true", help="All players are computer controlled")
args = parser.parse_args()

def isHuman(p):
    return p == 0 and not args.no_human

final_hands = []

for p in range(0, args.players):
    color = PLAYER_COLORS[p % len(PLAYER_COLORS)]
    divider("═")
    print("{}Player {}{}".format(color, p+1, RESET))
    hand = genHand(5)
    for h in range(0, 3):
        divider("─", "hand {}".format(h+1))
        diceToKeep = []
        if isHuman(p):
            showHand(hand)
            choice = input("  What to keep (comma separated list of dice (1-5) or null for exit)? ")
            choice = choice.replace(' ', '')
            opts = choice.split(',')
            if len(opts) == 0 or opts[0] == '':
                break
            for opt in opts:
                diceToKeep.append(hand[int(opt)-1])
        else:
            keep_indices = computerKeep(hand)
            diceToKeep = [hand[i] for i in keep_indices]
            kept_str = ', '.join(str(i+1) for i in keep_indices) if keep_indices else 'none'
            showHand(hand, keeps_str=kept_str)
            time.sleep(2)
        shortHand = genHand(5 - len(diceToKeep))
        hand = shortHand + diceToKeep
    divider("─", "final")
    showHand(hand)
    final_hands.append(hand)

divider("═")
winners = compareHands(final_hands)
if len(winners) == 1:
    w = winners[0]
    color = PLAYER_COLORS[w % len(PLAYER_COLORS)]
    print("{}Player {}{}  wins with {}!".format(color, w+1, RESET, handName(final_hands[w])))
else:
    parts = ["{}Player {}{}".format(PLAYER_COLORS[w % len(PLAYER_COLORS)], w+1, RESET) for w in winners]
    print("It's a tie between {}!".format(' and '.join(parts)))
divider("═")
