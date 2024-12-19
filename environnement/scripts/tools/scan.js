const fs = require("fs");
const path = require("path");
const config = require("./config/config"); // Importer la configuration
const { scanDirectory } = require("./lib/analyse-files"); // Importer les fonctions depuis lib/analyse-files.js

// Constantes depuis le fichier config.js
const { COMPOSE_COMMAND, OUTPUT_FILE, META_FILE } = config;

// Fonction principale
function main() {
  const startDirectory = process.argv[2]; // Récupérer le répertoire passé en argument

  if (!startDirectory) {
    console.error("Erreur : Veuillez fournir un répertoire à scanner.");
    console.log("Utilisation : node main.js <chemin_du_répertoire>");
    process.exit(1);
  }

  if (!fs.existsSync(startDirectory) || !fs.statSync(startDirectory).isDirectory()) {
    console.error(`Erreur : Le répertoire fourni n'existe pas ou n'est pas valide : ${startDirectory}`);
    process.exit(1);
  }

  console.log(`Scan en cours dans : ${startDirectory}\n`);

  const composeFiles = scanDirectory(startDirectory, startDirectory);

  if (composeFiles.length === 0) {
    console.log("Aucun fichier docker-compose trouvé ou aucun fichier ecmd-meta.json associé.");
    return;
  }

  console.log("Fichiers docker-compose trouvés avec leur metadata associée :\n");

  // Stocker le contenu dans une variable `output`
  let output = "";

  // Écrire l'en-tête dans la variable `output`
  output += `#!/bin/bash

# In order to exit if any command fails
set -e

WORKDIR=$PWD
echo WORKDIR: $WORKDIR
BASEDIR=$(dirname "$0")
echo BASEDIR: $BASEDIR
cd $BASEDIR

COLOR_TITLE="\\e[0;31m"
COLOR_DEFAULT="\\e[39m"
COLOR_PARAM="\\e[0;32m"
COLOR_CMD="\\e[1;37m"

`;

  // Gestion des fonctions basées sur les tags avec indexation
  const functionMap = new Map();
  const functionNameTab = [];

  composeFiles.forEach(({ path: filePath, dirname, basename, ecmdMeta }) => {
    const tag = ecmdMeta.tag || "defaultTag";

    // Initialiser un tableau pour les fichiers sous le même tag
    if (!functionMap.has(tag)) {
      functionMap.set(tag, []);
    }
    functionMap.get(tag).push({ dirname, basename, ecmdMeta });
  });

  let functionIndexMap = new Map(); // Suivi de l'index pour chaque tag
  functionMap.forEach((files, tag) => {
    files.forEach(({ dirname, basename, ecmdMeta }, index) => {
      // Ajouter un index au tag si nécessaire
      if (!functionIndexMap.has(tag)) {
        functionIndexMap.set(tag, 1);
      }
      const functionName = files.length > 1 ? `${tag}${functionIndexMap.get(tag)}` : tag;
      functionIndexMap.set(tag, functionIndexMap.get(tag) + 1);

      // Ajouter la fonction au contenu `output`
      output += `function ${functionName}() {\n`;
      output += `  cd ${dirname}\n`;
      output += `  ${COMPOSE_COMMAND} -f ${basename} up -d\n`;
      output += `  cd $WORKDIR\n`;
      output += `}\n`;

      functionNameTab.push({functionName, ecmdMeta});
    });
  });

  // function manual
  output += `
  function manual() {
    echo " "
    echo " "
    echo " "
    echo -e \${COLOR_TITLE}
    echo -e "################################################################"
    echo -e "# Usage: ecmd.sh  <param>                                      #"
    echo -e "################################################################"
    echo -e \${COLOR_PARAM}
    echo " -------------------------------------------------------------- "
    echo " -- PARAMS (env)                                             -- "
    echo " -------------------------------------------------------------- "
    echo -e \${COLOR_DEFAULT}
  `
  functionNameTab.forEach(({functionName, ecmdMeta} ) => {

    console.log(ecmdMeta);

    output += `
      echo -e "  \${COLOR_CMD}${functionName}\${COLOR_DEFAULT}\t\t\t: ${ecmdMeta.description || ''} at port ${ecmdMeta.port || '0'}"
    `;
  });


  
  
  output += `
    echo " -------------------------------------------------------------- "
    echo " "
    echo " "
  }
    
  if [ $# -eq 0 ]; then
    manual
    exit 0
  fi
  `



  // Ajouter le bloc `case` au contenu `output`
  output += 'case "$1" in\n';
  functionNameTab.forEach(({functionName, ecmdMeta}) => {
    output += `
    "${functionName}")
      ${functionName}
    ;;
    `;
  });
  output += `
    *)
      manual
    ;;
esac
`;

  // Chemin du fichier de sortie
  const outputFilePath = path.join(startDirectory, OUTPUT_FILE);

  // Écrire tout le contenu en une seule fois dans le fichier
  fs.writeFileSync(outputFilePath, output, { encoding: "utf8" });

  console.log(`Les résultats ont été enregistrés dans le fichier : ${outputFilePath}`);
}

// Lancement du script
main();
