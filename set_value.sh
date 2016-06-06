#!/bin/bash
##################################################################
#This script update the API with the new data (temperature value)
#should be passed as floating value in command line argument
##################################################################
if [ "$1" == "" ]; then
    echo "Usage $0 \"value\""
    exit 1
fi
VALUE="$1"

API_KEY="53b93e7ca0184b098b31943fe14f9b77"
THING_ID="1b6eac8e233711e69b064b58a7906d4e"
PROPERTY_ID="443a6651233711e69b064b58a7906d4e"

URL="http://api.gadgetkeeper.com"
TMP_FILE="/tmp/tmp.txt"
curl -i -X PUT -H "X-ApiKey: $API_KEY" -H "Content-Type: text/json; charset=UTF-8" -d "$VALUE" "$URL/v1/things/$THING_ID/properties/$PROPERTY_ID/value.json" > "$TMP_FILE" 2> /dev/null

if [ -f "$TMP_FILE" ]; then
    RESPONSE=`cat "$TMP_FILE" | head -1`
    IS_OK=`echo "$RESPONSE" | grep "HTTP/1.1 204"`
    if [ "$IS_OK" != "" ]; then
        echo "Value set: OK"
    else
        echo "Value set: FAIL"
        echo "$RESPONSE"
    fi
else
    echo "Error"
fi
