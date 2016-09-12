https://github.com/scoiatael/zosia-server.git:
  git.latest:
    - target: /srv/zosia-server

bash /srv/zosia-server/scripts/sync.sh | logger:
  cron.present:
    - user: root
    - minute: '*/5'
