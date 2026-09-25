import requests
from bs4 import BeautifulSoup
import urllib.parse

url = "https://forums.suse.com/c/k3s-k3os-k3d/19"
headers = {"User-Agent": "Mozilla/5.0"}

r = requests.get(url, headers=headers)
print(f"Status: {r.status_code}")
soup = BeautifulSoup(r.text, "html.parser")
items = soup.find_all("div", class_="forum-thread-list-item") or soup.select("tr.topic-row")

for i, item in enumerate(items[:10], 1):
    link_elem = item.find("a")
    if not link_elem:
        continue
    title = link_elem.get_text(strip=True)[:80] or f"Post {i}"
    href = urllib.parse.urljoin(url, link_elem["href"])
    print(f"[{i}] {title}")
    print(f"   {href}")
