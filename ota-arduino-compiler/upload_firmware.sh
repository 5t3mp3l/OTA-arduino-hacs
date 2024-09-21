#!/bin/bash
# $1 contains the IP address of the target Arduino device
# Upload the compiled firmware via TFTP

curl -T /data/arduino_sketches/ota_arduino/ota_arduino.ino.hex tftp://$1
