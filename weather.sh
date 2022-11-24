#!/bin/bash

LINK="http://api.weatherstack.com/current?"
ACCESS_KEY="access_key=c9a1bec4ff3fa8ff7bc62063d434a5c2"
#QUERRY="&query=New%20York"
QUERRY="&query=Wroclaw"

#DATA=$(cat <<EOF
#{"request":{"type":"City","query":"Wroclaw, Poland","language":"en","unit":"m"},"location":{"name":"Wroclaw","country":"Poland","region":"","lat":"51.100","lon":"17.033","timezone_id":"Europe\/Warsaw","localtime":"2022-11-24 14:31","localtime_epoch":1669300260,"utc_offset":"1.0"},"current":{"observation_time":"01:31 PM","temperature":3,"weather_code":116,"weather_icons":["https:\/\/cdn.worldweatheronline.com\/images\/wsymbols01_png_64\/wsymbol_0002_sunny_intervals.png"],"weather_descriptions":["Partly cloudy"],"wind_speed":4,"wind_degree":322,"wind_dir":"NW","pressure":1012,"precip":0.2,"humidity":87,"cloudcover":75,"feelslike":2,"uv_index":1,"visibility":7,"is_day":"yes"}}
#EOF
#)
DATA=$(curl -s "$LINK$ACCESS_KEY$QUERRY")


LOCATION=$(echo "$DATA" | jq -r '.location.name')
TEMPERATURE=$(echo "$DATA" | jq -r '.current.temperature')
WEATHER_DESCRIPTIONS=$(echo "$DATA" | jq -r '.current.weather_descriptions')
WIND_SPEED=$(echo "$DATA" | jq -r '.current.wind_speed')
CLOUD_COVER=$(echo "$DATA" | jq -r '.current.cloudcover')


printf "\nSprawdzasz pogodę w %s\nTemperatura wynosi: %s stopnie \nPrędkość wiatru wynosi: %skm/h\nProcent zachmurzenia: %s\nOpis pogody: %s\n" "$LOCATION" "$TEMPERATURE" "$WIND_SPEED" "$CLOUD_COVER" "$WEATHER_DESCRIPTIONS"



#http://api.weatherstack.com/current?access_key=c9a1bec4ff3fa8ff7bc62063d434a5c2&query=New%20York
