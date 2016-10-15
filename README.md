# Zosia Server

![](https://camo.githubusercontent.com/2b38d981b3b5f6702a9c5dad0e4886352638837e/68747470733a2f2f736d61746c792e636f6d2f746d702f636f6f6b696e672e6a7067)

## Letsencrypt

To set up certificate, run:
```
sudo letsencrypt certonly --webroot -w /var/www/well-known -d staging.zosia.org:
```

## Not covered:
* Datadog agent setup - simply follow steps on https://app.datadoghq.com/.

## Secrets
(on server)
* Edit `/srv/pillar/secrets.sls` to update secrets managed by Salt.
* Run `sudo salt-call --local state.apply` to sync afterwards

## Migrations
(on server)
* Ensure latest changes are pulled: `sudo bash /srv/zosia-site/scripts/sync.sh`
* sudo to zosia user: `sudo -iu zosia bash`
* cd to app directory `cd /var/www/app`
* source virtualenv `source ../env/bin/activate`
* run migrations `python manage.py migrate`
