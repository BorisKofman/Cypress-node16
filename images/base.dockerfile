FROM cypress/base:18.16.1

RUN apk update && \
    apk add --no-cache \
        openssl \
        ca-certificates \
        curl \
        unzip \
        dbus-x11 \
        libu2f-udev \
    && rm -rf /var/cache/apk/*

RUN npm install -g cpu-features

# Install ChromeDriver
RUN apk add --no-cache chromium-chromedriver

# "fake" dbus address to prevent errors
ENV DBUS_SESSION_BUS_ADDRESS=/dev/null