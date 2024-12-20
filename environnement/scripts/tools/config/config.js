const path = require("path");

// Configuration centralisée
module.exports = {
  COMPOSE_COMMAND: "docker compose", // Peut être remplacé par "podman-compose"
  COMMAND: "docker",
  OUTPUT_FILE: "ecmdg.sh",
  META_FILE: "ecmd-meta.json",
  CONFIG_DIR: path.resolve(__dirname),
};
