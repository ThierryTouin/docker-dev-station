const fs = require("fs");
const path = require("path");
const yaml = require("js-yaml"); // Nécessite la librairie "js-yaml" pour lire les fichiers YAML

// Constantes pour les noms de fichiers et commandes
const COMPOSE_COMMAND = "docker compose"; // Peut être remplacé par "podman-compose"
const OUTPUT_FILE = "ecmdg.sh";
const META_FILE = "ecmd-meta.json";

// Fonction pour vérifier si un fichier YAML semble être un fichier docker-compose
function isDockerComposeFile(filePath) {
  try {
    const content = fs.readFileSync(filePath, "utf8");
    const data = yaml.load(content);
    // Vérification des clés principales d'un fichier docker-compose
    return data && (data.services || data.version);
  } catch (err) {
    // Retourne faux si erreur d'analyse ou lecture
    return false;
  }
}

// Fonction récursive pour parcourir l'arborescence de fichiers
function scanDirectory(startDirectory, directory, composeFiles = []) {
  const files = fs.readdirSync(directory);
  let ecmdMetaContent = null;

  // Vérifier si le fichier ecmd-meta.json existe dans le répertoire courant
  const metaFilePath = path.join(directory, META_FILE);
  if (fs.existsSync(metaFilePath)) {
    try {
      const metaContent = fs.readFileSync(metaFilePath, "utf8");
      ecmdMetaContent = JSON.parse(metaContent);
    } catch (err) {
      console.error(`Erreur lors de la lecture de ${META_FILE}:`, err.message);
    }
  }

  // Parcourir les fichiers du répertoire
  files.forEach((file) => {
    const fullPath = path.join(directory, file);
    const stats = fs.statSync(fullPath);

    if (stats.isDirectory()) {
      // Parcourir récursivement les sous-dossiers
      scanDirectory(startDirectory, fullPath, composeFiles);
    } else if (stats.isFile()) {
      // Vérification des fichiers YAML ou similaires
      if ((file.endsWith(".yml") || file.endsWith(".yaml")) && ecmdMetaContent) {
        if (isDockerComposeFile(fullPath)) {
          const relativePath = path.relative(startDirectory, fullPath);
          console.log(`directory='${directory}'`);
          console.log(`fullPath='${fullPath}'`);          
          console.log(`relativePath='${relativePath}'`);
          console.log(`dirname='${path.dirname(relativePath)}'`);
          console.log(`basename='${path.basename(relativePath)}'`);
          composeFiles.push({
            path: fullPath,
            dirname: path.dirname(relativePath),
            basename: path.basename(relativePath),
            ecmdMeta: ecmdMetaContent
          });
        }
      }
    }
  });

  return composeFiles;
}

// Fonction principale
function main() {
  const startDirectory = process.argv[2]; // Récupérer le répertoire passé en argument

  if (!startDirectory) {
    console.error("Erreur : Veuillez fournir un répertoire à scanner.");
    console.log("Utilisation : node list-compose-commands.js <chemin_du_répertoire>");
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

  // Chemin du fichier de sortie
  const outputFilePath = path.join(startDirectory, OUTPUT_FILE);
  const outputStream = fs.createWriteStream(outputFilePath, { flags: 'w' });

  // Écrire l'en-tête dans le fichier de sortie
  const header = `#!/bin/bash

# In order to exit if any command fails
set -e

WORKDIR=$PWD
echo WORKDIR: $WORKDIR
BASEDIR=$(dirname "$0")
echo BASEDIR: $BASEDIR
cd $BASEDIR
#echo WORKDIR: $WORKDIR

# keep track of the last executed command
#trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
# echo an error message before exiting
#trap 'echo "\"\${last_command}\" command filed with exit code $?\."' EXIT

function manual() {

  echo " "
  echo " "
  echo " "
  echo "TODO"
  echo " "
  echo " "
  
  }
  
  if [ $# -eq 0 ]; then
  manual
  exit 0
fi


`;
  outputStream.write(header);

  // Gestion des fonctions basées sur les tags avec indexation
  const functionMap = new Map();
  const functionNameTab = [];


  composeFiles.forEach(({ path: filePath, dirname, basename, ecmdMeta }) => {
    const tag = ecmdMeta.tag || "defaultTag";

    // Initialiser un tableau pour les fichiers sous le même tag
    if (!functionMap.has(tag)) {
      functionMap.set(tag, []);
    }
    functionMap.get(tag).push({ dirname, basename });
  });

  let functionIndexMap = new Map(); // Suivi de l'index pour chaque tag
  functionMap.forEach((files, tag) => {
    files.forEach(({ dirname, basename }, index) => {
      // Ajouter un index au tag si nécessaire
      if (!functionIndexMap.has(tag)) {
        functionIndexMap.set(tag, 1);
      }
      const functionName = files.length > 1 ? `${tag}${functionIndexMap.get(tag)}` : tag;
      functionIndexMap.set(tag, functionIndexMap.get(tag) + 1);

      // Écrire la fonction dans le fichier de sortie
      outputStream.write(`function ${functionName}() {\n`);
      outputStream.write(`  cd ${dirname}\n`);
      outputStream.write(`  ${COMPOSE_COMMAND} -f ${basename} up -d\n`);
      outputStream.write(`  cd $WORKDIR\n`);
      outputStream.write(`}\n`);

      functionNameTab.push(functionName);

    });
  });

  outputStream.write('case "$1" in')
  functionNameTab.forEach((functionName) => {
    outputStream.write(`
    "${functionName}")
      ${functionName}
    ;;
    `);
  });
  outputStream.write(`
    *)
      manual
    ;;
    esac
  `);

  outputStream.end();
  console.log(`Les résultats ont été enregistrés dans le fichier : ${outputFilePath}`);
}

// Lancement du script
main();
