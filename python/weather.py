import requests
from datetime import date
import json
import sys

if len(sys.argv) > 1:
    today = sys.argv[1]
else:
    today = date.today().strftime("%Y%m%d")

stationList = ['IIAI8', 'LRIA']

req = requests.get('https://api.wunderground.com/api/c7862614119770b4/history_{}/lang:RO/q/RO/{}.json'.format(today, stationList[1]))
print(req.request.path_url)
data = json.loads(req.text)
for record in data['history']['observations']:
    date = '{}-{}-{} {}:{}'.format(record['date']['mday'], record['date']['mon'], record['date']['year'], record['date']['hour'], record['date']['min'])
    tempm = record['tempm']
    conds = record['conds']
    wspdm = record['wspdm']
    wdire = record['wdire']
    hum = record['hum']
    pressurem = record['pressurem']
    print('{}: Temp {} C, Pressure {} hPa, Wind speed {} km/h from {}, Humidity {}%, {}'. format(date, round(float(tempm)), pressurem, round(float(wspdm)), wdire, hum, conds))
#    print(json.dumps(record))

