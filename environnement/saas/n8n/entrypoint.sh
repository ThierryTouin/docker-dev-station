#!/usr/bin/env sh
set -euo pipefail

# Variables (à ajuster selon ton setup)
IMPORT_WORKFLOW_DIR="/import/workflows"
IMPORT_CREDENTIAL_DIR="/import/credentials"
FLAG_FILE="/home/node/.n8n/.import_done"   # fichier “marker” dans le volume n8n
N8N_URL=${N8N_URL:-"http://localhost:5678"}  # ou selon ton hostname interne
TIMEOUT=${TIMEOUT:-120}
ENV_FILE=${ENV_FILE:-"/import/.env"}        # chemin vers ton .env (modifie si besoin)
TMP_DIR=${TMP_DIR:-"/tmp/n8n_import_prepared"}

echo "=== Entrypoint wrapper n8n démarré ==="

# === Fonctions utilitaires pour la transformation ===
# Charge un .env simple et exporte les variables (ignore commentaires / lignes vides)
load_env_file() {
  f="${1:-$ENV_FILE}"
  if [ ! -f "$f" ]; then
    echo "ℹ️ Aucun fichier env trouvé à $f — pas de substitutions."
    return 0
  fi
  echo "🔐 Chargement des variables depuis $f"
  while IFS= read -r line || [ -n "$line" ]; do
    line=$(echo "$line" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')
    case "$line" in
      ''|\#*) continue ;;
    esac
    if echo "$line" | grep -qE '^[A-Za-z_][A-Za-z0-9_]*='; then
      key=$(printf '%s' "$line" | cut -d= -f1)
      val=$(printf '%s' "$line" | cut -d= -f2-)
      # remove surrounding quotes
      val=$(printf '%s' "$val" | sed -e 's/^"//' -e 's/"$//' -e "s/^'//" -e "s/'$//")
      export "$key=$val"
    fi
  done < "$f"
}

# Transforme un fichier JSON/YAML en écrivant le résultat dans dst
# Remplace $VAR et ${VAR} à partir des variables exportées (ou de .env via fallback)
transform_file() {
  src="$1"
  dst="$2"

  # s'assurer du dossier de destination
  mkdir -p "$(dirname "$dst")"

  # Si envsubst est disponible, on l'utilise : il gère $VAR et ${VAR}
  if command -v envsubst >/dev/null 2>&1; then
    envsubst < "$src" > "$dst"
    return 0
  fi

  # Sinon fallback : lit le .env et applique des sed successifs (moins sécurisé pour certains chars)
  if [ ! -f "$ENV_FILE" ]; then
    # aucun .env -> juste copier
    cp "$src" "$dst"
    return 0
  fi

  # Copie initiale
  cp "$src" "$dst"

  # Pour chaque KEY=VAL dans .env, on remplace ${KEY} et $KEY
  while IFS= read -r line || [ -n "$line" ]; do
    line=$(echo "$line" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')
    case "$line" in
      ''|\#*) continue ;;
    esac
    if echo "$line" | grep -qE '^[A-Za-z_][A-Za-z0-9_]*='; then
      key=$(printf '%s' "$line" | cut -d= -f1)
      val=$(printf '%s' "$line" | cut -d= -f2-)
      val=$(printf '%s' "$val" | sed -e 's/^"//' -e 's/"$//' -e "s/^'//" -e "s/'$//")
      # échapper slash et &
      esc=$(printf '%s' "$val" | sed -e 's/[\/&]/\\&/g')
      # remplacer ${KEY} et $KEY
      sed -i -e "s/\${$key}/$esc/g" -e "s/\$$key/$esc/g" "$dst"
    fi
  done < "$ENV_FILE"
}

# Affiche un diff (ou un aperçu) uniquement si dst != src
show_diff_if_changed() {
  src="$1"
  dst="$2"
  # Si cmp disponible, l'utiliser pour vérifier égalité
  if command -v cmp >/dev/null 2>&1; then
    if cmp -s "$src" "$dst"; then
      # identiques
      return 0
    fi
  else
    # fallback : use md5sum if available
    if command -v md5sum >/dev/null 2>&1; then
      s1=$(md5sum "$src" | cut -d' ' -f1)
      s2=$(md5sum "$dst" | cut -d' ' -f1)
      if [ "$s1" = "$s2" ]; then
        return 0
      fi
    fi
    # if neither tool, fall through and show preview (optimistic: assume changed)
  fi

  echo "📝 Le fichier préparé diffère de l'original :"

  if command -v diff >/dev/null 2>&1; then
    echo "---- diff (unifié) ----"
    diff -u "$src" "$dst" || true
    echo "---- fin diff ----"
    return 0
  fi

  # fallback si pas de diff : afficher un aperçu du préparé
  echo "⚠️ 'diff' non disponible, affichage des premières lignes de la version préparée:"
  echo "---- début aperçu ($dst) ----"
  head -n 60 "$dst" || true
  echo "---- fin aperçu ----"
}

# Prépare le dossier tmp
mkdir -p "$TMP_DIR"

# 1. Attendre que n8n soit prêt (migrations, DB, etc.) — mais ici n8n n'est pas encore démarré !
# On ne peut pas attendre healthz avant d’avoir lancé n8n. Donc l’ordre doit être :
# - lancer n8n en arrière-plan
# - attendre healthz
# - faire l’import si besoin
# - puis garder n8n en avant-plan (ou ré-attacher)

# Mais plus simple : importer avant de lancer n8n, si possible — si la DB accepte les écritures.

# 2. Vérifier le flag
if [ ! -f "$FLAG_FILE" ]; then
  echo "🔍 Aucun import detecté — lancement de l’import des workflows / credentials"

  # Charger .env dans l'environnement pour envsubst/fallback sed
  load_env_file "$ENV_FILE"

  # Vérifier que le répertoire d’import existe (WORKFLOWS)
  if [ -d "${IMPORT_WORKFLOW_DIR}" ]; then
    for f in "${IMPORT_WORKFLOW_DIR}"/*.json; do
      if [ -f "$f" ]; then
        base=$(basename "$f")
        prepared="$TMP_DIR/workflows/$base"
        echo "🔧 Transformation de $f -> $prepared"
        transform_file "$f" "$prepared"
        # afficher diff si changement
        show_diff_if_changed "$f" "$prepared"
        echo "📥 Import de $prepared via CLI"
        n8n import:workflow --input="$prepared" || {
          echo "❌ Échec import $f"
          exit 1
        }
      fi
    done
  else
    echo "⚠️ Aucun répertoire ${IMPORT_WORKFLOW_DIR} trouvé — rien à importer - workflow"
  fi

  # Vérifier que le répertoire d’import existe (CREDENTIALS)
  if [ -d "${IMPORT_CREDENTIAL_DIR}" ]; then
    for f in "${IMPORT_CREDENTIAL_DIR}"/*.json; do
      if [ -f "$f" ]; then
        base=$(basename "$f")
        prepared="$TMP_DIR/credentials/$base"
        echo "🔧 Transformation de $f -> $prepared"
        transform_file "$f" "$prepared"
        # afficher diff si changement
        show_diff_if_changed "$f" "$prepared"
        echo "📥 Import de $prepared via CLI"
        n8n import:credentials --input="$prepared" || {
          echo "❌ Échec import $f"
          exit 1
        }
      fi
    done
  else
    echo "⚠️ Aucun répertoire ${IMPORT_CREDENTIAL_DIR} trouvé — rien à importer - credentials"
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
