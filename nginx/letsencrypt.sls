/var/www/well-known:
  file.directory:
    - user: root

letsencrypt:
  pkg.installed

letsencrypt certonly --webroot -w /var/www/well-known -d staging.zosia.org --agree-tos | logger:
  cmd.run:
    - creates:  /etc/letsencrypt/live/staging.zosia.org/fullchain.pem

letsencrypt renew --agree-tos | logger:
  cron.present:
    - identifier: LETSENCRYPT_RENEW
    - user: root
    - hour: '*/12'
