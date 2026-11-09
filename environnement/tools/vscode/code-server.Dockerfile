# Start from the official code-server image
FROM codercom/code-server:latest

# Use a non-root user for installing packages
USER root

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        curl \
        nodejs \
        npm \
        unzip \
        wget \
        zip && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /home/coder/.sdkman && chown coder:coder /home/coder/.sdkman

ENV SDKMAN_DIR=/home/coder/.sdkman
ENV PATH="/home/coder/.sdkman/candidates/java/current/bin:/home/coder/.sdkman/candidates/maven/current/bin:${PATH}"
    

# Switch back to the coder user
USER coder

# Set the working directory to the home directory of 'coder'
WORKDIR /home/coder

# Expose the code-server port
EXPOSE 8080

# Start code-server
#CMD ["code-server", "--bind-addr", "0.0.0.0:8080"]