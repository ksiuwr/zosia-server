app-pkgs:
  pkg.installed:
    - names:
      - npm
      - git
    #   - libpq-dev
      - libpqxx-devel
      - python-virtualenv
    #   - python3-dev
      - python36-devel
      - zlib-devel
      - libjpeg-turbo
      - gcc

app-git:
  git.latest:
    - name:  https://github.com/ksiuwr/zosia16-site.git
    - target: /var/www/app/
    - force_fetch: true
    - require:
      - pkg: app-pkgs
  cmd.run:
    - name: chown -R zosia:zosia /var/www/app
    - require:
        - user: zosia-user

/etc/profile.d/python3.sh:
  file.managed:
    - source: salt://etc/profile.d/python3.sh

nodejs-ubuntu-fix:
  cmd.run:
    - name: ln -s /usr/bin/nodejs /usr/bin/node
    - creates: /usr/bin/node

/var/www/env:
  virtualenv.manage:
    - requirements: /var/www/app/requirements.txt
    - clear: false
    - python: python36
    - require:
      - pkg: app-pkgs
      - git: app-git

npm-deps:
  cmd.run:
    - cwd: /var/www/app/
    - name: npm i
    - require:
      - pkg: app-pkgs
      - git: app-git

bower-deps:
  cmd.run:
    - name: make deps
    - runas: zosia
    - cwd: /var/www/app/
    - require:
      - cmd: npm-deps
      - user: zosia-user

migrate:
  cmd.run:
    - name: /var/www/env/bin/python /var/www/app/manage.py migrate
    - runas: zosia
    - cwd: /var/www/app/
    - require:
      - git: app-git


generate-static:
  cmd.run:
    - name: /var/www/env/bin/python /var/www/app/manage.py collectstatic --no-input
    - require:
        - cmd: bower-deps


chown -R www-data:www-data /var/www/static:
  cmd.run:
    - onchanges:
        - cmd: generate-static

gunicorn_env:
  file.managed:
    - name: /etc/gunicorn.env
    - source: salt://etc/gunicorn.env
    - template: jinja
    - mode: 600

systemd_gunicorn_service:
  file.managed:
    - name: /etc/systemd/system/gunicorn.service
    - source: salt://etc/systemd/gunicorn.service
    - template: jinja
    - mode: 755
  module.wait:
    - name: service.systemctl_reload
    - watch:
      - file: systemd_gunicorn_service
  cmd.run:
    - name: systemctl daemon-reload
    - onchanges:
        - file: systemd_gunicorn_service
  service.running:
    - name: gunicorn.service
    - enable: True
    - onchanges:
      - git: app-git
    - require:
      - file: gunicorn_env
      - file: systemd_gunicorn_service
      - git: app-git
      - cmd: systemd_gunicorn_service

zosia-user:
  user.present:
    - name: zosia
