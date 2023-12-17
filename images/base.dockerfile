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
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean \
    && rm -rf /var/cache/apt/archives/*

RUN node -p "process.arch === 'arm64' ? 'Not downloading Chrome since we are on arm64: https://crbug.com/677140' : process.exit(1)" || \
  (wget --no-verbose -O /usr/src/google-chrome-stable_current_amd64.deb "http://dl.google.com/linux/chrome/deb/pool/main/g/google-chrome-stable/google-chrome-stable_114.0.5735.198-1_amd64.deb" && \
  dpkg -i /usr/src/google-chrome-stable_current_amd64.deb ; \
  apt-get install -f -y && \
  rm -f /usr/src/google-chrome-stable_current_amd64.deb)

# "fake" dbus address to prevent errors
ENV DBUS_SESSION_BUS_ADDRESS=/dev/null