nginx:
  pkg.installed

/etc/nginx/sites-enabled/default:
  file.managed:
    - source: salt://etc/nginx/sites-enabled/default
  service.running:
    - name: nginx
    - enable: True
    - reload: True
    - watch:
        - file: /etc/nginx/sites-enabled/default
