const fs = require("fs");
const path = require("path");
const yaml = require("js-yaml"); // Nécessite la librairie "js-yaml" pour lire les fichiers YAML

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
function scanDirectory(directory, composeFiles = []) {
  const files = fs.readdirSync(directory);

  files.forEach((file) => {
    const fullPath = path.join(directory, file);
    const stats = fs.statSync(fullPath);

    if (stats.isDirectory()) {
      // Parcourir récursivement les sous-dossiers
      scanDirectory(fullPath, composeFiles);
    } else if (stats.isFile()) {
      // Vérification des fichiers YAML ou similaires
      if (file.endsWith(".yml") || file.endsWith(".yaml")) {
        if (isDockerComposeFile(fullPath)) {
          composeFiles.push(fullPath);
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

  const composeFiles = scanDirectory(startDirectory);

  if (composeFiles.length === 0) {
    console.log("Aucun fichier docker-compose trouvé.");
    return;
  }

  console.log("Fichiers docker-compose trouvés et leurs commandes correspondantes :\n");

  // Chemin du fichier de sortie
  const outputFilePath = path.join(startDirectory, "ecmdg.sh");
  const outputStream = fs.createWriteStream(outputFilePath, { flags: 'w' });

  composeFiles.forEach((filePath) => {
    const relativePath = path.relative(startDirectory, filePath);
    const output = `- Fichier : ${relativePath}\n  Commande : docker-compose -f "${relativePath}" up -d\n  (ou avec podman-compose : podman-compose -f "${relativePath}" up -d)\n\n`;
    
    // Écrire dans le fichier
    outputStream.write(output);

    // Afficher dans la console
    console.log(output);
  });

  outputStream.end();
  console.log(`Les résultats ont été enregistrés dans le fichier : ${outputFilePath}`);
}

// Lancement du script
main();
