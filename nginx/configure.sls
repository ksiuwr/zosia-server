nginx_install_pkg:
  pkg.installed:
    - name: nginx

/etc/nginx/sites-enabled/:
  file.directory:
    - user: root
    - group: root
    - mode: 644
    - makedirs: True

nginx_config_file:
  file.managed:
    - name: /etc/nginx/sites-enabled/default
    - source: salt://nginx/files/default.jinja
    - template: jinja

nginx_service:
  service.running:
    - name: nginx
    - enable: True
    - reload: True
    - watch:
        - file: nginx_config_file

/var/www/html:
  file.directory:
    - user: zosia
    - group: zosia
    - mode: 644
    - makedirs: True

nginx_index:
  file.managed:
    - name: /var/www/html/index.html
    - source: salt://nginx/files/index.html

nginx_remove_default_index:
  file.absent:
    - name: /var/www/html/index.nginx-debian.html
