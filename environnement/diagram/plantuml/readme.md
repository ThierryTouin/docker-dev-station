# PlantUML Server

Serveur de rendu local utilisant l'image `plantuml/plantuml-server:jetty`.
Le conteneur `plantuml-server` expose son port interne 8080 uniquement sur
`127.0.0.1:18081`, sans utiliser le port 8080 de la machine.

## Commandes

Depuis la racine du depot :

```bash
./environnement/dcmd.sh plantuml
./environnement/dcmd.sh plantuml logs
./environnement/dcmd.sh plantuml down
```

Les actions `clean`, `shell` et `shellr` sont aussi disponibles, comme pour
les autres services. Le serveur est accessible sur http://127.0.0.1:18081.

## VS Code

Installer l'extension **PlantUML** (`jebbs.plantuml`) puis ajouter ces valeurs
aux parametres JSON de VS Code :

```json
{
  "plantuml.render": "PlantUMLServer",
  "plantuml.server": "http://127.0.0.1:18081"
}
```

Ouvrir un fichier `.puml` et utiliser la commande
**PlantUML: Preview Current Diagram**.

Cette adresse suppose que l'extension s'execute sur la machine qui heberge
Docker. Depuis un autre conteneur ou une machine distante, `127.0.0.1` ne
designe pas ce serveur.