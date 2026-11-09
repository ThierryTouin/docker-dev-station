# VS Code (code-server)

Reference : https://github.com/sar/code-container/blob/main/code-server.yaml

## Installation des outils

Les scripts sont montes en lecture seule (`:ro`) dans le conteneur.
Un `chmod +x` depuis le conteneur echoue donc avec `Read-only file system`.
Executez le script avec Bash, sans changer ses permissions :

```bash
bash ~/install.sh
bash ~/install.sh java maven
```

Pour installer React, placez-vous dans le projet contenant `package.json`, puis
lancez `bash ~/install.sh react`.

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