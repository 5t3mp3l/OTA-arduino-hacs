#!/bin/bash

# Path to Arduino sketch file and target device IP
SKETCH_FILE=$1
TARGET_IP=$2
BOARD_TYPE=$3

# Step 1: Compile the Arduino sketch
echo "Compiling Arduino code for board type: $BOARD_TYPE"
sh /usr/local/bin/build_arduino.sh "$SKETCH_FILE" "$BOARD_TYPE"

# Step 2: Upload the firmware via TFTP
echo "Uploading firmware to $TARGET_IP via TFTP"
sh /usr/local/bin/tftp_upload.sh "$TARGET_IP" "$SKETCH_FILE"
