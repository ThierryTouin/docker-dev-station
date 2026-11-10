# VS Code (code-server)

Reference : https://github.com/sar/code-container/blob/main/code-server.yaml

## Outils disponibles

L'image installe Eclipse Temurin Java 25 et Maven 3.9.11 au moment du build.
Verifiez leur disponibilite dans un terminal du conteneur :

```bash
java -version
mvn -version
```

React 17 est une dependance de chaque projet, pas un outil global de l'image.
Depuis la racine du projet contenant `package.json`, lancez :

```bash
bash ~/install.sh react
```

Les projets sont stockes dans `data/` sur la machine hote. Les reglages et
extensions de code-server sont conserves dans le volume Docker
`vscode_code_server` ; ne le supprimez pas avec `docker compose down -v` si vous
souhaitez les garder.

Le lancement via `start-vscode.sh` reconstruit l'image si necessaire et demarre
code-server en arriere-plan.

Pour modifier les scripts, editez `custom/scripts/` sur la machine hote.

## Commande ll

`ll` est un alias Bash, pas une commande standard. Utilisez `ls -alF` ou ajoutez
l'alias a votre session :

```bash
alias ll='ls -alF'
```

Pour le conserver dans les prochains terminaux Bash, ajoutez cette ligne a
`~/.bashrc` dans le conteneur. Sans volume dedie, cette modification sera perdue
si le conteneur est recree.