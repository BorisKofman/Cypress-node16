# Use a smaller base image
FROM cypress/base:20.9.0

ARG TARGETOS
ARG TARGETARCH
ARG DOCKER_VERSION=24.0.7
ARG BUILDX_VERSION=0.12.0

# Install required packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        openssl \
        ca-certificates \
        curl \
        unzip \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean \
    && rm -rf /var/cache/apt/archives/*

RUN export RUNNER_ARCH=${TARGETARCH} \
    && if [ "$RUNNER_ARCH" = "amd64" ]; then export DOCKER_ARCH=x86_64 ; fi \
    && if [ "$RUNNER_ARCH" = "arm64" ]; then export DOCKER_ARCH=aarch64 ; fi \
    && curl -fLo docker.tgz https://download.docker.com/${TARGETOS}/static/stable/${DOCKER_ARCH}/docker-${DOCKER_VERSION}.tgz \
    && tar zxvf docker.tgz \
    && rm -rf docker.tgz \
    && cp docker/docker /usr/bin/docker \
    && rn -rf docker \
    && mkdir -p /usr/local/lib/docker/cli-plugins \
    && curl -fLo /usr/local/lib/docker/cli-plugins/docker-buildx \
        "https://github.com/docker/buildx/releases/download/v${BUILDX_VERSION}/buildx-v${BUILDX_VERSION}.linux-${TARGETARCH}" \
    && chmod +x /usr/local/lib/docker/cli-plugins/docker-buildx