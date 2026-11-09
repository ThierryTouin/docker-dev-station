#!/usr/bin/env bash

set -euo pipefail

show_help() {
    cat <<'EOF'
Installateur d'outils pour l'environnement code-server

Utilisation :
  ./install.sh <outil> [outil ...]

Outils disponibles :
  java    Installe le JDK Eclipse Temurin 25 pour l'utilisateur coder.
  maven   Installe la dernière version stable de Maven pour coder.
  react   Ajoute React 17 et React DOM 17 au projet npm courant.

Pour React, lancez la commande depuis le dossier contenant package.json.
EOF
}

ensure_sdkman() {
    local sdkman_init="$HOME/.sdkman/bin/sdkman-init.sh"

    if [[ ! -f "$sdkman_init" ]]; then
        echo "Installation de SDKMAN..."
        curl -fsSL "https://get.sdkman.io" | bash
    fi

    # shellcheck disable=SC1090
    source "$sdkman_init"
}

install_java() {
    ensure_sdkman
    if [[ -d "$HOME/.sdkman/candidates/java/25-tem" ]]; then
        echo "Le JDK Temurin 25 est déjà installé."
        return
    fi

    echo "Installation du JDK Eclipse Temurin 25..."
    printf 'Y\n' | sdk install java 25-tem
}

install_maven() {
    ensure_sdkman
    if [[ -e "$HOME/.sdkman/candidates/maven/current" ]]; then
        echo "Maven est déjà installé."
        return
    fi

    echo "Installation de la dernière version stable de Maven..."
    printf 'Y\n' | sdk install maven
}

install_react() {
    if [[ ! -f package.json ]]; then
        echo "Erreur : aucun package.json dans le dossier courant." >&2
        echo "Placez-vous à la racine du projet npm avant de lancer install.sh react." >&2
        return 1
    fi

    echo "Installation de React 17.0.2 et React DOM 17.0.2 dans le projet courant..."
    npm install --save-exact react@17.0.2 react-dom@17.0.2
}

if [[ $# -eq 0 ]]; then
    show_help
    exit 0
fi

for tool in "$@"; do
    case "$tool" in
        java|maven|react) ;;
        *)
            echo "Erreur : outil inconnu '$tool'." >&2
            show_help >&2
            exit 2
            ;;
    esac
done

for tool in "$@"; do
    case "$tool" in
        java) install_java ;;
        maven) install_maven ;;
        react) install_react ;;
    esac
done