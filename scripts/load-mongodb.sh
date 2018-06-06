#!/bin/bash

# Loads hourly weather data from weather stations around the globe into mongod.
# Note: Must have a mongod process running!

START=2018
END=2018

mkdir temp/;
cd temp/;

for YR in $(seq $START $END); do

    echo "+==============================+";
    echo "| Begin loading data for $YR. |";
    echo "+==============================+";

    # Download global hourly climate data for the year
    wget https://www.ncei.noaa.gov/data/global-hourly/archive/$YR.tar.gz;

    # Extract contents
    tar -xzvf $YR.tar.gz;
    
    for weatherstationdata in ./*.csv; do
	mongoimport -d noaaClimateData -c globalHourly --type csv --file $weatherstationdata --headerline && rm -f $weatherstationdata;
    done

    echo "Done loading data for $YR.";
    echo "";
done

cd ../;
rm -rf temp/;
