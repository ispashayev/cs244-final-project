#!/bin/bash

# Adds hourly weather data from weatherstations around the globe into mongod

START=2015
END=2018

for YR in $(seq $START $END); do
    # Download global hourly climate data for the year
    sudo wget https://www.ncei.noaa.gov/data/global-hourly/archive/$YR.tar.gz -P=~/efs/;

    # Extract contents
    sudo tar -xzvf ~/efs/$YR.tar.gz;
    
    for weatherstationdata in ~/efs/*.csv; do
	mongoimport -d noaaClimateData -c globalHourly --type csv --file "$weatherstationdata" --headerline && sudo rm -f "$weatherstationdata";
    done
done
