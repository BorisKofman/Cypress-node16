# Use Ubuntu 22.04 (Jammy) as the base image
FROM ubuntu:jammy

# Set Node.js version as a build argument
ARG NODE=20

# Avoid any prompts
ENV DEBIAN_FRONTEND noninteractive

# Set environment variables for better npm experience
ENV TERM xterm
ENV npm_config_loglevel warn
ENV npm_config_unsafe_perm true

# Update the package manager and install necessary tools
RUN apt-get update && \
    apt-get install -y apt-transport-https ca-certificates curl gnupg build-essential git unzip wget

# Add Node.js repository and install Node.js
RUN mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg && \
    echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_${NODE}.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list && \
    apt-get update && \
    apt-get install -y nodejs

# Install the latest NPM and Yarn
RUN npm install -g npm@latest && \
    npm install -g yarn@latest

# Install additional dependencies
RUN apt-get install -y \
    libatk1.0-0 \
    libgtk2.0-0 \
    libglib2.0-0 \
    libatk-bridge2.0-0 \
    libcups2 \
    libgtk-3-0 \
    libgbm1 \
    libnotify-dev \
    libgconf-2-4 \
    libnss3 \
    libxss1 \
    libasound2 \
    xvfb \
    dbus \
    cmake

# Install Google Chrome browser
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    echo "deb http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list && \
    apt-get update && \
    apt-get install -y dbus-x11 google-chrome-stable && \
    rm -rf /var/lib/apt/lists/*

# Set "fake" DBUS address to prevent errors
ENV DBUS_SESSION_BUS_ADDRESS=/dev/null

# Generate and print machine-id for DBUS
RUN dbus-uuidgen > /var/lib/dbus/machine-id 
    # dbus-daemon --config-file=/usr/share/dbus-1/system.conf --print-address

# Create a user named "runner"
RUN mkdir -p /run/dbus 

# Start the DBUS service
RUN service dbus start

# Set the working directory
WORKDIR /home/runner

# Display version information
RUN echo "Node version: $(node -v)" && \
    echo "NPM version: $(npm -v)" && \
    echo "Yarn version: $(yarn -v)" && \
    echo "Debian version: $(cat /etc/debian_version)" && \
    echo "User: $(whoami)" && \
    echo "Git version: $(git --version)"

# Display additional version information
RUN cat /etc/lsb-release && \
    cat /etc/os-release

# Install CPU-features globally
RUN npm install -g cpu-features