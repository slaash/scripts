import json
import argparse
from datetime import date
from termcolor import colored
import requests

DEBUG = False
stationList = ['zmw:00000.133.15090', 'RO/LRIA', 'RO/pws:IIAI8', 'RO/pws:IIASIIAS4', 'zmw:00000.1.15300']
station = stationList[0]

def history(day):
    req = requests.get('https://api.wunderground.com/api/c7862614119770b4/history_{}/lang:RO/q/{}.json'.format(day, station))
    req.raise_for_status()
    if DEBUG:
        print(req.request.path_url)
    data = json.loads(req.text)
    records = []
    for record in data['history']['observations']:
        conds = record.get('conds', '')
#        if len(conds) == 0:
#            continue
        time = '{}-{}-{} {}:{}'.format(record['date']['mday'], record['date']['mon'], record['date']['year'], record['date']['hour'], record['date']['min'])
        tempm = record['tempm']
        wspdm = record['wspdm']
        wdire = record['wdire']
        hum = record['hum']
        pressurem = record['pressurem']
        records.append('{}: Temp {} C, Pressure {} hPa, Wind {} km/h from {}, Humidity {} %, {}'.format(colored(time, attrs=['bold']), colored(round(float(tempm)), 'green'), colored(pressurem, 'blue'), colored(round(float(wspdm)), 'yellow'), wdire, colored(hum, 'magenta'), colored(conds, 'cyan')))
    return records

def forecast():
    req = requests.get('https://api.wunderground.com/api/c7862614119770b4/forecast10day/lang:RO/q/{}.json'.format(station))
    req.raise_for_status()
    if DEBUG:
        print(req.request.path_url)
    data = json.loads(req.text)
    records = []
    for record in data['forecast']['simpleforecast']['forecastday']:
        time = '{}, {} {}'.format(record['date']['weekday'], record['date']['day'], record['date']['monthname'])
        cond = record['conditions']
        low = record['low']['celsius']
        high = record['high']['celsius']
        maxwind = record['maxwind']['kph']
        maxwind_dir = record['maxwind']['dir']
        avewind = record['avewind']['kph']
        avehumidity = record['avehumidity']
        records.append('{}: Temp {}/{} C, Wind {}(max {}) km/h from {}, Humidity {} %, {}'.format(colored(time, attrs=['bold']), colored(low, 'blue'), colored(high, 'red'), colored(avewind, 'yellow'), colored(maxwind, 'red'), maxwind_dir, colored(avehumidity, 'magenta'), colored(cond, 'cyan')))
    return records

def conditions():
    req = requests.get('https://api.wunderground.com/api/c7862614119770b4/conditions/lang:RO/q/{}.json'.format(station))
    req.raise_for_status()
    if DEBUG:
        print(req.request.path_url)
    data = json.loads(req.text)
    record = data['current_observation']
    time = record['observation_time']
    weather = record['weather']
    temp_c = record['temp_c']
    relative_humidity = record['relative_humidity']
    wind_string = record['wind_string']
    wind_kph = record['wind_kph']
    wind_dir = record['wind_dir']
    pressure_mb = record['pressure_mb']
    feelslike_c = record['feelslike_c']
    return '{}: Temp {}(feels like {}) C, Wind {} km/h from {} ({}), Pressure {} hPa, Humidity {},  {}'.format(colored(time, attrs=['bold']), colored(round(float(temp_c)), 'green'), colored(round(float(feelslike_c)), 'red'), colored(wind_kph, 'yellow'), wind_dir, colored(wind_string, 'blue'), colored(pressure_mb, 'blue'), colored(relative_humidity, 'magenta'), colored(weather, 'cyan'))

def astronomy():
    req = requests.get('https://api.wunderground.com/api/c7862614119770b4/astronomy/q/zmw:00000.133.15090.json')
    req.raise_for_status()
    if DEBUG:
        print(req.request.path_url)
    data = json.loads(req.text)
    sunrise_h = data['sun_phase']['sunrise']['hour']
    sunrise_m = data['sun_phase']['sunrise']['minute']
    sunset_h = data['sun_phase']['sunset']['hour']
    sunset_m = data['sun_phase']['sunset']['minute']
    moonrise_h = data['moon_phase']['moonrise']['hour']
    moonrise_m = data['moon_phase']['moonrise']['minute']
    moonset_h = data['moon_phase']['moonset']['hour']
    moonset_m = data['moon_phase']['moonset']['minute']
    percentIlluminated = data['moon_phase']['percentIlluminated']
    ageOfMoon = data['moon_phase']['ageOfMoon']
    return 'Sunrise {}:{}, sunset {}:{}, moonrise {}:{}, moonset {}:{}, Moon illuminated {}%, Moon age {} days'.format(sunrise_h, sunrise_m, sunset_h, sunset_m, moonrise_h, moonrise_m, moonset_h, moonset_m, percentIlluminated, ageOfMoon)

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument('--date', '-d', default=date.today().strftime("%Y%m%d"),
                        help='The date to show weather for')
    parser.add_argument('--history', '-H', action="store_true",
                        help='Shows historical weather data')
    parser.add_argument('--forecast', '-f', action="store_true",
                        help='Shows a weather summary for the next 3 days')
    parser.add_argument('--station', '-s', default=stationList[0],
                        help='The weather station (one of {})'.format(stationList))
    parser.add_argument('--debug', '-D', action="store_true",
                        help='Turns on debug info')
    ns = parser.parse_args()

    DEBUG = ns.debug
    station = ns.station

    if ns.history:
        for rec in history(ns.date):
            print(rec)
    elif ns.forecast:
        for rec in forecast():
            print(rec)
    else:
        print(conditions())
        print(astronomy())
