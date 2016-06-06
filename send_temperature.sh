#!/bin/bash 
 
#For DHT11 model
#For DS18B20 model
SCRIPT="/home/pi/gadgetkeeper/read_temperature.py"
#For DHT22 model
#SCRIPT="/root/gadgetkeeper/Adafruit_DHT 22 4"
#For AM2302 model
#SCRIPT="/root/gadgetkeeper/Adafruit_DHT 2302 4"
while true;do
	TEMPRATURE=`$SCRIPT | grep "Temp" | awk -F " " '{print $3}'`
	if [ "$TEMPRATURE" != "" ]; then
     		echo "Current temperature: $TEMPRATURE"
       		/home/pi/gadgetkeeper/set_value.sh "$TEMPRATURE"
       		
	else
       		echo "Retry after 2s"
       		sleep 2
       		TRY=`expr $TRY + 1`
	fi
	sleep 5
	#echo $TEMPRATURE 
	done
