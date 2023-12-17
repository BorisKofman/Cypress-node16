# Use a smaller base image
FROM cypress/base:18.16.1

# Install required packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        openssl \
        ca-certificates \
        curl \
        unzip \
        dbus-x11 \
        libu2f-udev \
        google-chrome-stable \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean \
    && rm -rf /var/cache/apt/archives/*

# "fake" dbus address to prevent errors
ENV DBUS_SESSION_BUS_ADDRESS=/dev/null