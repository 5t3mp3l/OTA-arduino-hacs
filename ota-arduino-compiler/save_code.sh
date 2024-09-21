#!/bin/bash
# $1 contains the Arduino code as an argument
# Save the code into the specified sketch file

echo "$1" > /data/arduino_sketches/ota_arduino/ota_arduino.ino
