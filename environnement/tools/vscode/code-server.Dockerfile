FROM codercom/code-server:latest AS code

FROM rootpublic/eclipse-temurin:21.0.5_11-jdk-bookworm-slim_rootio AS java

FROM code

USER root

# Copie du JDK Temurin
COPY --from=java /opt/java/openjdk /opt/java/openjdk

ENV JAVA_HOME=/opt/java/openjdk
ENV PATH="${JAVA_HOME}/bin:${PATH}"

# Outils système
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        maven \
        nodejs \
        npm \
        unzip \
        wget \
        zip \
        git \
        curl && \
    rm -rf /var/lib/apt/lists/*

# Préparation des répertoires code-server
RUN mkdir -p /home/coder/.local/share/code-server && \
    mkdir -p /home/coder/.config/code-server && \
    chown -R coder:coder /home/coder

# Installation des extensions sous l'utilisateur coder
USER coder

RUN code-server \
        --install-extension vscjava.vscode-java-pack \
        --force

WORKDIR /home/coder

EXPOSE 8080