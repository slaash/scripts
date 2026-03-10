#!/usr/bin/env python3
"""
Eiffel Tower Ticket Availability Checker
Displays the latest date when tickets can be bought based on official policy
(60 days in advance for lift tickets, 14 days for stairs tickets)
"""

from datetime import datetime, timedelta
import sys


def check_ticket_availability():
    """Calculate latest booking dates based on official Eiffel Tower policy"""
    
    print("Eiffel Tower Ticket Availability")
    print("=" * 50)
    
    today = datetime.now()
    
    # Official policy: tickets sold up to 60 days in advance for lift
    lift_date = today + timedelta(days=60)
    stairs_date = today + timedelta(days=14)
    
    print(f"\n✓ Latest lift ticket date: {lift_date.strftime('%B %d, %Y')}")
    print(f"  ({lift_date.strftime('%Y-%m-%d')})")
    print(f"  [60 days from today]")
    
    print(f"\n✓ Latest stairs ticket date: {stairs_date.strftime('%B %d, %Y')}")
    print(f"  ({stairs_date.strftime('%Y-%m-%d')})")
    print(f"  [14 days from today]")
    
    print(f"\n📅 Today: {today.strftime('%B %d, %Y')}")
    print(f"\nℹ Visit https://ticket.toureiffel.paris/en to book tickets")
    print(f"  Note: Popular dates sell out quickly, book in advance!")


url = "https://ticket.toureiffel.paris/en"

if __name__ == "__main__":
    check_ticket_availability()
