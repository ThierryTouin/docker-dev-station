FROM node:14-slim

# Installer les dépendances nécessaires
RUN apt-get update && apt-get install -y \
    libnss3 \
    libasound2 \
    && rm -rf /var/lib/apt/lists/*

# Installer Mermaid CLI
RUN npm install -g @mermaid-js/mermaid-cli puppeteer

# Définir le point d'entrée
ENTRYPOINT ["mmdc"]
