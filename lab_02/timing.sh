#!/bin/bash

TOTAL=0
for ((i = 0; i < 10; i++)) 
do
    TOTAL+=$(time ./app.exe | grep user)
done
