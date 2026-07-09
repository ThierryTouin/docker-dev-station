#!/bin/sh
# Gestion du conteneur Firefox (linuxserver)

cd "$(dirname "$0")" || exit 1

COMPOSE_FILE="./docker-compose.yml"
PORT="3001"

start() {
    echo "Démarrage de Firefox..."
    docker compose -f "$COMPOSE_FILE" up -d
    echo "Firefox démarré sur \e[92mhttps://localhost:$PORT \e[0m"
}

logs() {
    echo "Logs de Firefox (Ctrl+C pour quitter)..."
    docker compose -f "$COMPOSE_FILE" logs -f
}

stop() {
    echo "Arrêt de Firefox..."
    docker compose -f "$COMPOSE_FILE" down
}

clean() {
    echo "Arrêt de Firefox et suppression des volumes..."
    docker compose -f "$COMPOSE_FILE" down -v
    echo "Suppression du dossier de config local..."
    rm -rf ./firefox-config
    echo "Nettoyage terminé."
}

help() {
    echo "Usage: $0 {start|logs|stop|clean|help}"
    echo ""
    echo "  start   Démarre le conteneur Firefox"
    echo "  logs    Affiche les logs du conteneur"
    echo "  stop    Arrête le conteneur"
    echo "  clean   Arrête le conteneur, supprime les volumes et la config locale"
    echo "  help    Affiche cette aide"
}

case "$1" in
    start) start ;;
    logs)  logs ;;
    stop)  stop ;;
    clean) clean ;;
    help|"") help ;;
    *)
        echo "Commande inconnue: $1"
        echo ""
        help
        exit 1
        ;;
esac
