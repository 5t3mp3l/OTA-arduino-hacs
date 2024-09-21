#!/bin/bash

# Arduino sketch file and board type
SKETCH_FILE=$1
BOARD_TYPE=$2

# Compile the Arduino sketch using Arduino CLI
arduino-cli compile --fqbn $BOARD_TYPE "$SKETCH_FILE"

if [ $? -ne 0 ]; then
    echo "Arduino compilation failed!"
    exit 1
fi

echo "Arduino compilation succeeded!"
