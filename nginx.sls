nginx:
  pkg.installed

/etc/nginx/sites-enabled/default:
  file.managed:
    - source: salt://etc/nginx/sites-enabled/default

nginx-restart:
  service.running:
    - name: nginx
    - require_in:
        - file: /etc/nginx/sites-enabled/default
