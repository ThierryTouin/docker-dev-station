# Start from the official code-server image
FROM codercom/code-server:latest

# Use a non-root user for installing packages
USER root

COPY --from=java-certs cert_Palo-Outb-Inspection-Trust.crt /usr/local/share/ca-certificates/palo-outb-inspection-trust.crt

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        nodejs \
        npm \
        unzip \
        wget \
        zip && \
    update-ca-certificates && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /home/coder/.sdkman && chown coder:coder /home/coder/.sdkman

ENV SDKMAN_DIR=/home/coder/.sdkman

RUN curl -fsSL "https://get.sdkman.io" | bash && \
    bash -c 'source "$SDKMAN_DIR/bin/sdkman-init.sh" && \
        printf "Y\n" | sdk install java 25-tem && \
        printf "Y\n" | sdk install maven 3.9.11 && \
        "$SDKMAN_DIR/candidates/java/25-tem/bin/keytool" -importcert -noprompt -trustcacerts \
            -alias palo-outb-inspection-trust \
            -file /usr/local/share/ca-certificates/palo-outb-inspection-trust.crt \
            -keystore "$SDKMAN_DIR/candidates/java/25-tem/lib/security/cacerts" \
            -storepass changeit'

ENV PATH="/home/coder/.sdkman/candidates/java/current/bin:/home/coder/.sdkman/candidates/maven/current/bin:${PATH}"

# Switch back to the coder user
USER coder

# Set the working directory to the home directory of 'coder'
WORKDIR /home/coder

# Expose the code-server port
EXPOSE 8080

# Start code-server
#CMD ["code-server", "--bind-addr", "0.0.0.0:8080"]