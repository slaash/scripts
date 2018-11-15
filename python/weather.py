import json
import argparse
from datetime import date
from termcolor import colored
import requests

DEBUG = False
stationList = ['/q/zmw:00000.139.15090', '/q/zmw:00000.133.15090', '/q/RO/LRIA', '/q/RO/pws:IIAI8', '/q/RO/pws:IIASIIAS4', '/q/zmw:00000.1.15300', '/q/zmw:00000.1.15480']
station = stationList[0]

def history(day):
    req = requests.get('https://api.wunderground.com/api/c7862614119770b4/history_{}/lang:RO{}.json'.format(day, station))
    req.raise_for_status()
    if DEBUG:
        print(req.request.path_url)
    data = json.loads(req.text)
    records = []
    for record in data['history']['observations']:
        conds = record.get('conds', '')
        time = '{}-{}-{} {}:{}'.format(record['date']['mday'], record['date']['mon'], record['date']['year'], record['date']['hour'], record['date']['min'])
        tempm = record['tempm']
        wspdm = record['wspdm']
        wdire = record['wdire']
        hum = record['hum']
        pressurem = record['pressurem']
        records.append('{}: Temp {} C, Pressure {} hPa, Wind {} km/h from {}, Humidity {} %, {}'.format(colored(time, attrs=['bold']), colored(round(float(tempm)), 'green'), colored(pressurem, 'blue'), colored(round(float(wspdm)), 'yellow'), wdire, colored(hum, 'magenta'), colored(conds, 'cyan')))
    return records

def forecast():
    req = requests.get('https://api.wunderground.com/api/c7862614119770b4/forecast10day/lang:RO{}.json'.format(station))
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

def hourly():
    req = requests.get('https://api.wunderground.com/api/c7862614119770b4/hourly/lang:RO{}.json'.format(station))
    req.raise_for_status()
    if DEBUG:
        print(req.request.path_url)
    data = json.loads(req.text)
    records = []
    for record in data['hourly_forecast']:
        time = '{}, {}:{} {}'.format(record['FCTTIME']['weekday_name'], record['FCTTIME']['hour'], record['FCTTIME']['min'], record['FCTTIME']['ampm'])
        cond = record['condition']
        temp = record['temp']['metric']
        wind_spd = record['wspd']['metric']
        wind_dir = record['wdir']['dir']
        pressure = record['mslp']['metric']
        humidity = record['humidity']
        records.append('{} - Temp {} C, Wind {} km/h from {}, Humidity {} %, Pressure {} hPa, {}'.format(colored(time, attrs=['bold']), colored(temp, 'blue'), colored(wind_spd, 'yellow'), wind_dir, colored(humidity, 'magenta'), colored(pressure, 'blue'), colored(cond, 'cyan')))
    return records

def conditions():
    req = requests.get('https://api.wunderground.com/api/c7862614119770b4/conditions/lang:RO{}.json'.format(station))
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
    req = requests.get('https://api.wunderground.com/api/c7862614119770b4/astronomy{}.json'.format(station))
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

def info():
    req = requests.get('https://api.wunderground.com/api/c7862614119770b4/geolookup{}.json'.format(station))
    req.raise_for_status()
    if DEBUG:
        print(req.request.path_url)
    data = json.loads(req.text)
    city = data['location']['city']
    country_name = data['location']['country_name']
    name = data['location']['l']
    lat = data['location']['lat']
    lon = data['location']['lon']
    return '{} Location: {}, {} Coordinates: {}, {}'.format(name, city, country_name, lat, lon)

def query(name):
    req = requests.get('https://api.wunderground.com/api/c7862614119770b4/geolookup/q/{}.json'.format(name))
    req.raise_for_status()
    if DEBUG:
        print(req.request.path_url)
    data = json.loads(req.text)
    if 'location' in data.keys():
        return data['location']['l']
    elif 'results' in data['response'].keys():
        for res in data['response']['results']:
            print(res)
        exit()

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument('--date', '-d', default=date.today().strftime("%Y%m%d"),
                        help='The date to show weather for')
    parser.add_argument('--history', '-H', action="store_true",
                        help='Shows historical weather data')
    parser.add_argument('--forecast', '-f', action="store_true",
                        help='Shows a weather summary for the next 3 days')
    parser.add_argument('--hourly', '-g', action="store_true",
                        help='Shows a weather summary for the next hours')
    parser.add_argument('--station', '-s', default=stationList[0],
                        help='The weather station (one of {})'.format(stationList))
    parser.add_argument('--info', '-i', action="store_true",
                        help='Weather station info')
    parser.add_argument('--query', '-q',
                        help='Search for location')
    parser.add_argument('--debug', '-D', action="store_true",
                        help='Turns on debug info')
    ns = parser.parse_args()

    DEBUG = ns.debug
    if ns.query:
        station = query(ns.query)
    else:
        station = ns.station

    if ns.info:
        print(info())

    if ns.history:
        for rec in history(ns.date):
            print(rec)
    elif ns.forecast:
        for rec in forecast():
            print(rec)
    elif ns.hourly:
        for rec in hourly():
            print(rec)
    else:
        print(conditions())
        print(astronomy())

