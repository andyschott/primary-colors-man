#!/bin/bash

rsa_key_size=4096
data_path="./certbot"
email="andy@andyschott.com"
declare -a domains=("swgoh.primarycolorsman.com")
dry_run="0"

domain_args=""
for domain in "${domains[@]}"; do
    domain_args="$domain_args -d $domain"
done

email_arg="--email $email"

dry_run_arg=""
if [ $dry_run != "0" ]; then
    dry_run_arg="--dry-run"
fi
echo "dry_run_arg is '$dry_run_arg'"

echo "### Requesting Let's Encrypt certificate for $domains ..."
docker compose -f "docker-compose.yml" run --rm --entrypoint "\
  certbot certonly --webroot -w /var/www/certbot \
    $dry_run_arg \
    $email_arg \
    $domain_args \
    --rsa-key-size $rsa_key_size \
    --agree-tos \
    --force-renewal" certbot
echo
