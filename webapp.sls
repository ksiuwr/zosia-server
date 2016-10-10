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
    - no_site_packages: true
    - clear: false
    - require:
      - pkg: app-pkgs
      - git: app-git
