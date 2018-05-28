#!/bin/bash

# Adds hourly weather data from weatherstations around the globe into mongod

cd ~/efs;

START=2015
END=2018

for YR in $(seq $START $END); do
    if [ $YR -eq 2017 ]; then
	# Already loaded data for 2017
	continue
    fi

    echo "Begin loading data for $YR.";

    # Download global hourly climate data for the year
    sudo wget https://www.ncei.noaa.gov/data/global-hourly/archive/$YR.tar.gz;

    # Extract contents
    sudo tar -xzvf $YR.tar.gz;
    
    for weatherstationdata in ./*.csv; do
	mongoimport -d noaaClimateData -c globalHourly --type csv --file "$weatherstationdata" --headerline && sudo rm -f "$weatherstationdata";
    done

    echo "Done loading data for $YR.";
done
