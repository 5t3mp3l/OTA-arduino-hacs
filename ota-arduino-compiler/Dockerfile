# Base image for Home Assistant Add-ons
ARG BUILD_FROM=ghcr.io/hassio-addons/base/amd64:9.1.5
FROM ${BUILD_FROM}

# Set environment variables
ENV LANG C.UTF-8

# Install required packages: Arduino CLI and TFTP
RUN apk add --no-cache bash git curl tftp-hpa arduino-cli

# Create working directories for Arduino sketches
WORKDIR /data/arduino

# Install Arduino CLI core and board definitions
RUN arduino-cli core update-index
RUN arduino-cli core install arduino:avr

# Copy custom scripts for saving, compiling, and uploading code
COPY tftp_server.sh /usr/local/bin/tftp_server.sh
COPY save_code.sh /usr/local/bin/save_code.sh
COPY compile_code.sh /usr/local/bin/compile_code.sh
COPY upload_firmware.sh /usr/local/bin/upload_firmware.sh
COPY setup_home_assistant.sh /usr/local/bin/setup_home_assistant.sh

# Make scripts executable
RUN chmod +x /usr/local/bin/tftp_server.sh
RUN chmod +x /usr/local/bin/save_code.sh
RUN chmod +x /usr/local/bin/compile_code.sh
RUN chmod +x /usr/local/bin/upload_firmware.sh
RUN chmod +x /usr/local/bin/setup_home_assistant.sh

# Expose necessary ports (TFTP uses UDP port 69)
EXPOSE 69/udp

# Run the setup script on startup
CMD [ "/usr/local/bin/tftp_server.sh", "/usr/local/bin/setup_home_assistant.sh" ]
