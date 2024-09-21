# Use Debian as the base image for better package support
FROM debian:bullseye-slim

# Set environment variables
ENV LANG C.UTF-8
ENV PATH="/root/bin:${PATH}"

# Install required packages: bash, git, curl, tftp-hpa, and Arduino CLI
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    bash \
    git \
    curl \
    tftp-hpa \
    && rm -rf /var/lib/apt/lists/*

# Install Arduino CLI using the official script and ensure it's in the PATH
RUN curl -fsSL https://raw.githubusercontent.com/arduino/arduino-cli/master/install.sh | sh && \
    mv /root/bin/arduino-cli /usr/local/bin/arduino-cli

# Create working directories for Arduino sketches
WORKDIR /data/arduino

# Install Arduino CLI core and board definitions
RUN arduino-cli core update-index && \
    arduino-cli core install arduino:avr

# Copy custom scripts for saving, compiling, and uploading code
COPY tftp_server.sh /usr/local/bin/tftp_server.sh
COPY save_code.sh /usr/local/bin/save_code.sh
COPY compile_code.sh /usr/local/bin/compile_code.sh
COPY upload_firmware.sh /usr/local/bin/upload_firmware.sh
COPY setup_home_assistant.sh /usr/local/bin/setup_home_assistant.sh

# Make scripts executable
RUN chmod +x /usr/local/bin/tftp_server.sh \
    /usr/local/bin/save_code.sh \
    /usr/local/bin/compile_code.sh \
    /usr/local/bin/upload_firmware.sh \
    /usr/local/bin/setup_home_assistant.sh

# Expose necessary ports (TFTP uses UDP port 69)
EXPOSE 69/udp

# Start TFTP server and run the setup script during installation
CMD [ "/usr/local/bin/tftp_server.sh", "/usr/local/bin/setup_home_assistant.sh" ]
