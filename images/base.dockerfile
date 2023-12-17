# Use the Cypress base image as the base image
FROM cypress/base:18.16.1

# Install openssl, ca-certificates, curl, unzip, dbus-x11, cmake, build-essential, and git
RUN apt-get update && \
    apt-get install -y openssl ca-certificates curl unzip dbus-x11 libu2f-udev  && \
    rm -rf /var/lib/apt/lists/*


# Install Google Chrome
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
  && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
  && apt-get update \
  && apt-get install -y google-chrome-stable \
  && rm -rf /var/lib/apt/lists/*

# "fake" dbus address to prevent errors
# https://github.com/SeleniumHQ/docker-selenium/issues/87
ENV DBUS_SESSION_BUS_ADDRESS=/dev/null