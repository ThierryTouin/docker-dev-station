const path = require("path");

// Configuration centralisée
module.exports = {
  COMPOSE_COMMAND: "docker compose", // Peut être remplacé par "podman-compose"
  COMMAND: "docker",
  OUTPUT_FILE: "dcmd.sh",
  OUTPUT_COMPLETION_FILE: "dcmd_completion.sh",
  META_FILE: "ecmd-meta.json",
  CONFIG_DIR: path.resolve(__dirname),
  OUTPUT_UI_FILE: "ui/react-app/public/links.json"
};
