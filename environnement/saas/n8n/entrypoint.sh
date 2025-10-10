#!/usr/bin/env sh
set -euo pipefail

# Variables (à ajuster selon ton setup)
IMPORT_DIR="/import"
FLAG_FILE="/home/node/.n8n/.import_done"   # fichier “marker” dans le volume n8n
N8N_URL=${N8N_URL:-"http://localhost:5678"}  # ou selon ton hostname interne
TIMEOUT=${TIMEOUT:-120}

echo "=== Entrypoint wrapper n8n démarré ==="

# 1. Attendre que n8n soit prêt (migrations, DB, etc.) — mais ici n8n n'est pas encore démarré !
# On ne peut pas attendre healthz avant d’avoir lancé n8n. Donc l’ordre doit être :
# - lancer n8n en arrière-plan
# - attendre healthz
# - faire l’import si besoin
# - puis garder n8n en avant-plan (ou ré-attacher)

# Mais plus simple : importer avant de lancer n8n, si possible — si la DB accepte les écritures.

# 2. Vérifier le flag
if [ ! -f "$FLAG_FILE" ]; then
  echo "🔍 Aucun import detecté — lancement de l’import des workflows"

  # Vérifier que le répertoire d’import existe
  if [ -d "${IMPORT_DIR}" ]; then
    for f in "${IMPORT_DIR}"/*.json; do
      if [ -f "$f" ]; then
        echo "📥 Import de $f via CLI"
        n8n import:workflow --input="$f" || {
          echo "❌ Échec import $f"
          exit 1
        }
      fi
    done
  else
    echo "⚠️ Aucun répertoire ${IMPORT_DIR} trouvé — rien à importer"
  fi

  # Créer le flag pour ne pas réimporter la prochaine fois
  touch "$FLAG_FILE"
  echo "✅ Import terminé, flag créé"
else
  echo "✅ Import déjà fait — on saute cette étape"
fi

echo "📦 Démarrage de n8n"
#exec "$@"  # ceci lance la commande CMD (ex: n8n start) à la place du shell
n8n start