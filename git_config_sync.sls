https://github.com/ksiuwr/zosia-server.git:
  git.latest:
    - target: /srv/zosia-server

bash /srv/zosia-server/scripts/sync.sh | logger:
  cron.present:
    - identifier: GIT_CONFIG_SYNC
    - user: root
    - minute: '*/5'

/etc/salt/minion:
  file.managed:
    - source: salt://etc/salt/minion

/srv/pillar/top.sls:
  file.managed:
    - source: salt://etc/pillar/top.sls

/srv/pillar/secrets.sls:
  file.managed:
    - source: salt://pillar.example.sls
    - unless:
        - ls /srv/pillar/secrets.sls

