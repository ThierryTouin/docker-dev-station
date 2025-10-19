https://black-lab.fr/automatiser-avec-n8n-en-auto-hebergement-ia-securite-et-scalabilite/


docker compose -f n8n-compose.yml exec n8n-init sh

docker compose -f n8n-compose.yml exec n8n sh


curl -s -X POST -u "demo@test.com:test" -H "Content-Type: application/json" --data @/home/node/import/workflows/wkf1.json "http://dds-n8n:5678/rest/workflows"


curl -s -X POST -u "demo@test.com:test" -H "Content-Type: application/json" --data @./n8n-data/import/workflows/wkf1.json "http://localhost:15678/rest/workflows"

curl -s -X POST -H "X-N8N-API-KEY: votre_clé_api_ici" -H "Content-Type: application/json" --data-binary @./n8n-data/import/workflows/wkf1.json "http://localhost:15678/api/v1/workflows"




curl http://dds-n8n:5678/healthz


curl -v -u "demo@test.com:test" http://dds-n8n:5678/rest/workflows

## Command
n8n export:credentials --all

{"createdAt":"2025-10-19T20:38:16.893Z","updatedAt":"2025-10-19T20:38:16.879Z","id":"A8QGF4LgnCiQQz9Q","name":"Ollama account","data":"U2FsdGVkX18DjOopIohitI+UOzMnvAHSDS29+cmoP8SfA9IsozZttn1Gh6t7ploq3nIgk3yFPbPGTGRkzBp4o8eq/at1zP7avQAEEDdTZzpzPC8NPDL9e9F3I+Qws5CPVPYqxHFCxAnbuGIXrzFWfQ==","type":"ollamaApi","isManaged":false}

n8n export:credentials --all --decrypted

[{"createdAt":"2025-10-19T20:38:16.893Z","updatedAt":"2025-10-19T20:38:16.879Z","id":"A8QGF4LgnCiQQz9Q","name":"Ollama account","data":{"baseUrl":"http://ollama2:11434","apiKey":"sk-48cc491556fb42e182c29fd75720509a"},"type":"ollamaApi","isManaged":false}]


## Liens 
https://hackceleration.com/fr/tutoriel/creer-un-agent-ia-sur-n8n/

https://github.com/n8n-io/self-hosted-ai-starter-kit