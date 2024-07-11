# Utiliser une image de base légère
FROM alpine:latest

ARG CONTAINER_NAME

# Installer Docker CLI
RUN apk --no-cache add docker-cli

# Copier le script dans l'image
COPY check-container-healthy.sh /usr/local/bin/check-container-healthy.sh

# Rendre le script exécutable
RUN chmod +x /usr/local/bin/check-container-healthy.sh

RUN ls -al /usr/local/bin/

# Définir le point d'entrée
# ENTRYPOINT /usr/local/bin/check-container-healthy.sh ${CONTAINER_NAME}


# Ajouter une vérification de santé
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 CMD /usr/local/bin/check-container-healthy.sh "${CONTAINER_NAME}"

CMD ["tail", "-f", "/dev/null"]