FROM cypress/browsers:node-16.18.1-chrome-110.0.5481.96-1-ff-109.0-edge-110.0.1587.41-1


#ENV
ENV DEBIAN_FRONTEND noninteractive
# a few environment variables to make NPM installs easier
# good colors for most applications
ENV TERM=xterm
# avoid million NPM install messages
ENV npm_config_loglevel=warn
# allow installing when the main user is root
ENV npm_config_unsafe_perm=true
# "fake" dbus address to prevent errors
# https://github.com/SeleniumHQ/docker-selenium/issues/87
ENV DBUS_SESSION_BUS_ADDRESS=/dev/null

USER root

RUN apt update -y && \
    apt install -y \
    unzip \
    cmake \
    build-essential \
    tzdata \
    xvfb \
    dbus 

#DBUS
RUN dbus-uuidgen > /var/lib/dbus/machine-id

RUN service dbus start 

RUN npm install -g node-gyp
RUN npm install -g cpu-features

RUN rm -rf ~/.node_modules