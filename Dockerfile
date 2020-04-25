FROM ubuntu:20.04

# Create working directory
WORKDIR /kodi/build

# Kodi source code has to be mounted in this folder
VOLUME /kodi/source

# Kodi will be built in this folder
VOLUME /kodi/build

# Install build dependencies
RUN apt-get update; \
    apt-get install --assume-yes software-properties-common; \
    add-apt-repository --enable-source ppa:team-xbmc/xbmc-nightly; \
    apt-get build-dep --assume-yes kodi;

# Add build script
COPY build.sh /usr/local/bin

# Create user
RUN groupadd --gid 1000 build; \
    useradd --uid 1000 --gid build --shell /bin/bash --create-home build;

# Use `build`-user to create files with matching permissions
USER build