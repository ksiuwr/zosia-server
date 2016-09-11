nginx:
  pkg.installed

/etc/nginx/sites-enabled/default:
  file.managed:
    - source: salt://etc/nginx/sites-enabled/default
