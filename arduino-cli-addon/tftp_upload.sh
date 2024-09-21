#!/bin/bash

# Target IP address and sketch file
TARGET_IP=$1
SKETCH_FILE=$2

# Path to the compiled firmware (assuming .ino.hex file is generated)
HEX_FILE="${SKETCH_FILE%.ino}.ino.hex"

if [ ! -f "$HEX_FILE" ]; then
    echo "Firmware file not found: $HEX_FILE"
    exit 1
fi

# Upload the firmware via TFTP
tftp $TARGET_IP <<EOF
put $HEX_FILE
EOF

if [ $? -ne 0 ]; then
    echo "TFTP upload failed!"
    exit 1
fi

echo "TFTP upload succeeded!"
