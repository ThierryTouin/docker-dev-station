from traefik:2.10.7

run touch /acme/acme.json \
  && chmod 600 /acme/acme.json