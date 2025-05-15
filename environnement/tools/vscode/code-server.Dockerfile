# Start from the official code-server image
FROM codercom/code-server:latest

# Use a non-root user for installing packages
USER root

RUN apt-get update && \
    apt-get install wget -y
    
# Switch back to the coder user
USER coder

# Set the working directory to the home directory of 'coder'
WORKDIR /home/coder

# Expose the code-server port
EXPOSE 8080

# Start code-server
#CMD ["code-server", "--bind-addr", "0.0.0.0:8080"]