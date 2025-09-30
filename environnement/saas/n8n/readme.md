https://black-lab.fr/automatiser-avec-n8n-en-auto-hebergement-ia-securite-et-scalabilite/


docker compose -f n8n-compose.yml exec n8n-init sh

docker compose -f n8n-compose.yml exec n8n sh


curl -s -X POST -u "demo@test.com:test" -H "Content-Type: application/json" --data @/home/node/import/workflows/wkf1.json "http://dds-n8n:5678/rest/workflows"


curl -s -X POST -u "demo@test.com:test" -H "Content-Type: application/json" --data @./n8n-data/import/workflows/wkf1.json "http://localhost:15678/rest/workflows"

curl -s -X POST -H "X-N8N-API-KEY: votre_clé_api_ici" -H "Content-Type: application/json" --data-binary @./n8n-data/import/workflows/wkf1.json "http://localhost:15678/api/v1/workflows"




curl http://dds-n8n:5678/healthz


curl -v -u "demo@test.com:test" http://dds-n8n:5678/rest/workflows
