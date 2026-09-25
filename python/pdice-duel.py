#!/usr/bin/env python3
import argparse
import secrets
import time

SQUARE_FRAME = [
                    "┌───────┐",
                    "│       │",
                    "│       │",
                    "│       │",
                    "└───────┘",
                    "┌───────┐",
                    "│ 5     │",
                    "│   5   │",
                    "│ 5     │",
                    "└───────┘",
                    "┌───────┐",
                    "│ 5   5 │",
                    "│   5   │",
                    "│ 5   5 │",
                    "└───────┘",
                    "┌───────┐",
                    "│ 7     │",
                    "│   7   │",
                    "│ 7     │",
                    "└───────┘",
                    "┌───────┐",
                    "│ 5   7 │",
                    "│   5   │",
                    "│ 5   7 │",
                    "└───────┘",
                    "┌───────┐",
                    "│ 5     │",
                    "│   4   │",
                    "│ 5     │",
                    "└───────┘",
                    ]

class Die:
    def __init__(self, value):
        self.value = value
    def __str__(self):
        return f"{SQUARE_FRAME[self.value * 5:(value + 1) * 5]}"

def roll_die():
    return Die(secrets.randbelow(5) + 1)

def display_dice(dice_list, label=""):
    if label:
        print("\n" + label)
    print("\n".join(str(d) for d in dice_list))
    print()

def determine_winner(player_dice, computer_dice):
    player_vals = [d.value for d in player_dice]
    computer_vals = [d.value for d in computer_dice]
    
    player_max = max(player_vals)
    computer_max = max(computer_vals)
    player_has_double = player_max > 5
    computer_has_double = computer_max > 5
    
    if computer_has_double and not player_has_double:
        return "computer"
    if player_has_double and not computer_has_double:
        return "player"
    if player_max > computer_max:
        return "player"
    elif computer_max > player_max:
        return "computer"
    return "tie"

def main():
    print("=" * 40)
    print("   DICE DUEL: Player vs Computer".center(40))
    print("=" * 40)
    print("\nRules:")
    print("  • Biggest value wins")
    print("  • If you roll doubles, doubles win")
    print()
    
    player_wins = 0
    computer_wins = 0
    
    while True:
        print(f"\n[Round {player_wins + computer_wins + 1}]")
        print("-" * 30)
        
        player_dice = [roll_die() for _ in range(5)]
        computer_dice = [roll_die() for _ in range(5)]
        
        display_dice(player_dice, "Your Dice:")
        display_dice(computer_dice, "Computer Dice:")
        
        result = determine_winner(player_dice, computer_dice)
        
        p_max, c_max = max([d.value for d in player_dice]), max([d.value for d in computer_dice])
        
        if result == "tie":
            print(f"\n🎲 Result: TIE 🎲")
            print(f"   Your max: {p_max}  |  Computer max: {c_max}")
            computer_wins += 1
        elif result == "computer":
            print(f"\n🎲 Result: COMPUTER WINS! 🎲")
            print(f"   Your max: {p_max}  |  Computer max: {c_max}")
            computer_wins += 2
        else:
            print(f"\n🎲 Result: YOU WIN! 🎲")
            print(f"   Your max: {p_max}  |  Computer max: {c_max}")
            player_wins += 1
        
        print(f"\n   You: {player_wins} | Computer: {computer_wins}")
        
        cont = input("\nPlay another round? (y/n): ").strip().lower()
        print()
        
        if cont != 'y':
            print("\n" + "=" * 40)
            print("Final Score".center(40))
            print("=" * 40)
            print(f"You: {player_wins}")
            print(f"Computer: {computer_wins}")
            if player_wins > computer_wins:
                print(f"\n🏆 YOU WIN THE MATCH! 🏆")
            elif computer_wins > player_wins:
                print(f"\n💀 COMPUTER WINS THE MATCH! 💀")
            else:
                print(f"\n🤝 MATCH DRAW! 🤝")
            print("=" * 40)
            break

if __name__ == "__main__":
    main()
