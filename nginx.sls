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

/var/www/html/index.html:
  file.managed:
    - source: salt://html/index.html

remove-default-index:
  file.absent:
    - name: /var/www/html/index.nginx-debian.html:
 
