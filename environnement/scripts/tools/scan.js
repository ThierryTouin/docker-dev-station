const fs = require("fs");
const path = require("path");
const config = require("./config/config");
const { scanDirectory } = require("./lib/analyse-files");
const { generateEcmdContent } = require("./lib/gen-ecmd-content");
const { generateEcmdCompletionContent } = require("./lib/gen-ecmd-completion-content");
const { generateEcmdUI } = require("./lib/gen-ecmd-ui");
const { prepareFunctionTab } = require("./lib/prepare-function");

function main() {
  const startDirectory = process.argv[2];

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


  const functionTab = prepareFunctionTab(composeFiles, config);
  functionTab.forEach(({ functionName, ecmdMeta, dirname, basename }) => {
    console.log(`functionName=${functionName}`);
    console.log(`dirname=${dirname}`);
    console.log(`basename=${basename}`);
    console.log(`ecmdMeta=${JSON.stringify(ecmdMeta)}`);
  });

  const outputEcmd = generateEcmdContent(functionTab, config);
  const outputFilePath = path.join(startDirectory, config.OUTPUT_FILE);
  fs.writeFileSync(outputFilePath, outputEcmd, { encoding: "utf8" });
  console.log(`Les résultats ont été enregistrés dans le fichier : ${outputFilePath}`);

  const outputEcmdCompletion = generateEcmdCompletionContent(functionTab);
  const outputCompletionFilePath = path.join(startDirectory, config.OUTPUT_COMPLETION_FILE);
  fs.writeFileSync(outputCompletionFilePath, outputEcmdCompletion, { encoding: "utf8" });
  console.log(`Les résultats ont été enregistrés dans le fichier : ${outputCompletionFilePath}`);

  const outputEcmdUI = generateEcmdUI(functionTab);
  console.log(`String for ecmd ui : ${outputEcmdUI}`);
}

main();
