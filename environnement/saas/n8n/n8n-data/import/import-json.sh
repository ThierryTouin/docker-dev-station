#!/bin/sh
set -euo pipefail

#N8N_HOST="${N8N_HOST:-http://n8n:5678}"
N8N_HOST="http://dds-n8n:5678"
N8N_BASIC_AUTH_USER=demo@test.com
N8N_BASIC_AUTH_PASSWORD=test
IMPORT_DIR="${IMPORT_DIR:-/home/node/import/workflows}"
TIMEOUT_SECONDS=120

echo "🚀 Script d'import de workflows N8N démarré"
echo "📡 Endpoint attendu : ${N8N_HOST}/healthz"
echo "📂 Répertoire d'import : ${IMPORT_DIR}"

# --- 1. Attente que N8N soit prêt ---
echo "⏳ Attente que N8N soit prêt...at ${N8N_HOST}/healthz"

start_time=$(date +%s)
while true; do
  response=$(curl -s "${N8N_HOST}/healthz" || true)
  echo "response=" + $response
  if [ "$response" = '{"status":"ok"}' ]; then
    echo "✅ N8N est prêt !"
    break
  fi

  now=$(date +%s)
  elapsed=$(( now - start_time ))
  if [ "$elapsed" -ge "$TIMEOUT_SECONDS" ]; then
    echo "❌ N8N ne s'est jamais lancé après ${TIMEOUT_SECONDS}s. Abandon."
    exit 1
  fi

  echo "⏳ N8N pas encore prêt... (${elapsed}s)"
  sleep 2
done

# --- 2. Import des workflows JSON ---
if [ ! -d "$IMPORT_DIR" ]; then
  echo "⚠️ Aucun répertoire d'import trouvé à $IMPORT_DIR"
  exit 0
fi

WORKFLOW_FILES=$(find "$IMPORT_DIR" -type f -name "*.json")
if [ -z "$WORKFLOW_FILES" ]; then
  echo "⚠️ Aucun fichier JSON trouvé dans $IMPORT_DIR"
else
  echo "📦 Import des workflows..."
  for file in $WORKFLOW_FILES; do
    echo "📥 Import de $file ..."
    curl -s -X POST \
      -u "${N8N_BASIC_AUTH_USER}:${N8N_BASIC_AUTH_PASSWORD}" \
      -H "Content-Type: application/json" \
      --data @"$file" \
      "${N8N_HOST}/rest/workflows" >/dev/null

    if [ $? -eq 0 ]; then
      echo "✅ Importé : $file"
    else
      echo "❌ Échec de l'import : $file"
    fi
  done
fi

echo "🎉 Tous les imports terminés."


# --- bloquer le conteneur ---
tail -f /dev/null

echo "👋 Arrêt du conteneur init."

exit 0
