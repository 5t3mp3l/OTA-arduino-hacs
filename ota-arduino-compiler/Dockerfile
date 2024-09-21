# Use Debian as the base image for better package support
FROM debian:bullseye-slim

# Set environment variables
ENV LANG C.UTF-8

# Install required packages: bash, git, curl, tftp-hpa, and dependencies for Arduino CLI
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    bash \
    git \
    curl \
    tftp-hpa \
    ca-certificates \
    libc6 \
    libstdc++6 \
    && rm -rf /var/lib/apt/lists/*

# Download and install a specific version of Arduino CLI (v0.32.0)
RUN curl -fSL https://downloads.arduino.cc/arduino-cli/arduino-cli_0.32.0_Linux_64bit.tar.gz -o arduino-cli.tar.gz && \
    echo "Downloaded Arduino CLI archive:" && ls -lah arduino-cli.tar.gz && \
    tar -xzf arduino-cli.tar.gz && \
    echo "Extracted contents:" && ls -lah && \
    mv arduino-cli*/arduino-cli /usr/local/bin/arduino-cli && \
    chmod +x /usr/local/bin/arduino-cli && \
    rm -rf arduino-cli.tar.gz arduino-cli_0.32.0_Linux_64bit

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
