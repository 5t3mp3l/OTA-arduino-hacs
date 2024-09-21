#!/bin/bash

# Path to Home Assistant configuration directory
CONFIG_PATH="/config"

# Add entities and shell commands to configuration.yaml
echo "Adding required entities to configuration.yaml..."

cat <<EOT >> "$CONFIG_PATH/configuration.yaml"

# OTA Arduino HACS Entities
input_text:
  ota_arduino_sketch:
    name: "Arduino Sketch"
    max: 65535

  ota_arduino_ip:
    name: "Arduino IP Address"
    initial: "192.168.1.100"  # Replace with your Arduino's IP

input_number:
  ota_arduino_tolerance:
    name: "Tolerance Level"
    initial: 5
    min: 0
    max: 100
    step: 1

input_boolean:
  ota_arduino_home:
    name: "Home Mode"
    initial: false

shell_command:
  save_arduino_code: >
    echo "{{ states('input_text.ota_arduino_sketch') }}" > /data/arduino_sketches/ota_arduino/ota_arduino.ino

  compile_arduino_code: >
    arduino-cli compile --fqbn arduino:avr:uno /data/arduino_sketches/ota_arduino

  upload_firmware: >
    curl -T /data/arduino_sketches/ota_arduino/ota_arduino.ino.hex tftp://{{ states('input_text.ota_arduino_ip') }}

EOT

# Create a default Lovelace dashboard if not already present
LOVELACE_PATH="$CONFIG_PATH/ui-lovelace.yaml"
if [ ! -f "$LOVELACE_PATH" ]; then
  echo "Creating Lovelace dashboard..."

  cat <<EOT >> "$LOVELACE_PATH"
title: OTA Arduino Control
views:
  - title: OTA Arduino
    path: ota_arduino
    cards:
      - type: custom:mushroom-title-card
        title: Arduino OTA Dashboard
        subtitle: Manage and update your Arduino devices

      - type: custom:mushroom-template-card
        primary: "Arduino Sketch Editor"
        secondary: "Edit and upload Arduino code"
        icon: mdi:code-braces
        entity: input_text.ota_arduino_sketch

      - type: button
        name: Save Code
        icon: mdi:content-save
        tap_action:
          action: call-service
          service: shell_command.save_arduino_code

      - type: button
        name: Compile Code
        icon: mdi:code-tags
        tap_action:
          action: call-service
          service: shell_command.compile_arduino_code

      - type: button
        name: Upload Firmware
        icon: mdi:upload
        tap_action:
          action: call-service
          service: shell_command.upload_firmware

EOT

  echo "Lovelace dashboard created successfully."
else
  echo "Lovelace dashboard already exists."
fi

echo "Setup completed successfully."
