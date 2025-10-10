FROM docker.n8n.io/n8nio/n8n

USER root

# Copier le script d’entrypoint personnalisé
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

USER node

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]



# Keep container alive
CMD tail -f /dev/null  # 👈 conteneur ne se termine jamais