FROM cypress/base:18.16.1

# Install openssl and ca-certificates
RUN apt-get update && \
    apt-get install -y openssl ca-certificates curl unzip && \
    rm -rf /var/lib/apt/lists/*

# Any other customizations or commands you may need