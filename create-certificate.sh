#!/bin/bash

rsa_key_size=4096
data_path="./certbot"
email="andy@andyschott.com"
declare -a domains=("primarycolorsman.com")
dry_run="0"

if [ ! -e "$data_path/conf/options-ssl-nginx.conf" ] || [ ! -e "$data_path/conf/ssl-dhparams.pem" ]; then
    echo "### Downloading recommended TLS parameters ..."
    mkdir -p "$data_path/conf"
    curl -s https://raw.githubusercontent.com/certbot/certbot/master/certbot-nginx/certbot_nginx/_internal/tls_configs/options-ssl-nginx.conf >"$data_path/conf/options-ssl-nginx.conf"
    curl -s https://raw.githubusercontent.com/certbot/certbot/master/certbot/certbot/ssl-dhparams.pem >"$data_path/conf/ssl-dhparams.pem"
    echo
fi

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
