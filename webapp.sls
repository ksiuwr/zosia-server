app-pkgs:
  pkg.installed:
    - names:
      - git
      - python-virtualenv
      - python-dev

app-git:
  git.latest:
    - name:  https://github.com/ksiuwr/zosia16-site.git
    - target: /var/www/app/
    - force: true
    - require:
      - pkg: app-pkgs

/var/www/env:
  virtualenv.manage:
    - requirements: /var/www/app/requirements.txt
    - clear: false
    - python: python3
    - require:
      - pkg: app-pkgs
      - git: app-git

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
  service.running:
    - enable: True
    - reload: True
    - require:
      - file: systemd_gunicorn_service
