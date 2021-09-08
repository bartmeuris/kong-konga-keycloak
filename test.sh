#!/bin/bash

HOST_IP=`ip address show dev eth0 | grep "inet " | grep -oE '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1`

RAWTKN=$(curl -s -X POST \
        -H "Content-Type: application/x-www-form-urlencoded" \
        -d "username=test" \
        -d "password=test" \
        -d 'grant_type=password' \
        -d "client_id=myapp" \
        http://${HOST_IP}:8180/auth/realms/experimental/protocol/openid-connect/token \
        | jq . )
TKN=$(echo $RAWTKN | jq -r '.access_token')

echo "$TKN"
# curl -vvv "http://${HOST_IP}:8000/mock" -H "Accept: application/json" -H "Authorization: Bearer $TKN"
curl -vvv "http://${HOST_IP}:8000/mock" -H "Accept: application/json"