FROM debian:bookworm-slim

# Install necessary packages
RUN apt-get update && apt-get install -y wget curl sudo ca-certificates procps && \
    rm -rf /var/lib/apt/lists/*
    
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

VOLUME ["/usr/local/mesh_services/meshagent"]

WORKDIR /usr/local/mesh_services/meshagent
ENTRYPOINT ["/entrypoint.sh"]

