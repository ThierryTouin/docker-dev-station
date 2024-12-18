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
function scanDirectory(startDirectory, directory, composeFiles = [], metaFileName = "ecmd-meta.json") {
    //console.log(`startDirectory='${startDirectory}'`);
    console.log(`directory='${directory}'`);
    const files = fs.readdirSync(directory);
  let ecmdMetaContent = null;

  // Vérifier si le fichier de metadata (ex: ecmd-meta.json) existe dans le répertoire courant
  const metaFilePath = path.join(directory, metaFileName);
  if (fs.existsSync(metaFilePath)) {
    try {
      const metaContent = fs.readFileSync(metaFilePath, "utf8");
      ecmdMetaContent = JSON.parse(metaContent);
    } catch (err) {
      console.error(`Erreur lors de la lecture de ${metaFileName}:`, err.message);
    }
  }

  // Parcourir les fichiers du répertoire
  files.forEach((file) => {
    //console.log(`file='${file}'`);
    const fullPath = path.join(directory, file);
    const stats = fs.statSync(fullPath);

    if (stats.isDirectory()) {
      // Parcourir récursivement les sous-dossiers
      scanDirectory(startDirectory, fullPath, composeFiles, metaFileName);
    } else if (stats.isFile()) {
      // Vérification des fichiers YAML ou similaires
      if ((file.endsWith(".yml") || file.endsWith(".yaml")) && ecmdMetaContent) {
        if (isDockerComposeFile(fullPath)) {
          const relativePath = path.relative(startDirectory, fullPath);
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

module.exports = {
  scanDirectory,
};
