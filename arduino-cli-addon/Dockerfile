# Base image for Home Assistant add-ons
FROM debian:bullseye-slim

# Set environment variables
ENV LANG C.UTF-8

# Install required packages: bash, git, curl, tftp-hpa, and dependencies for Arduino CLI
RUN apt-get update && apt-get install -y --no-install-recommends \
    bash \
    git \
    curl \
    tftp-hpa \
    ca-certificates \
    libc6 \
    libstdc++6 && \
    rm -rf /var/lib/apt/lists/*

# Install Arduino CLI (direct download of stable version)
RUN curl -fSL https://downloads.arduino.cc/arduino-cli/arduino-cli_0.32.0_Linux_64bit.tar.gz -o arduino-cli.tar.gz && \
    tar -xzf arduino-cli.tar.gz && \
    mv arduino-cli*/arduino-cli /usr/local/bin/arduino-cli && \
    chmod +x /usr/local/bin/arduino-cli && \
    rm -rf arduino-cli.tar.gz arduino-cli_0.32.0_Linux_64bit

# Copy custom scripts
COPY run.sh /usr/local/bin/run.sh
COPY build_arduino.sh /usr/local/bin/build_arduino.sh
COPY tftp_upload.sh /usr/local/bin/tftp_upload.sh

# Make custom scripts executable
RUN chmod +x /usr/local/bin/run.sh /usr/local/bin/build_arduino.sh /usr/local/bin/tftp_upload.sh

# Expose TFTP port (UDP port 69)
EXPOSE 69/udp

# Command to start the add-on
CMD [ "/usr/local/bin/run.sh" ]
