https://github.com/scoiatael/zosia-server.git:
  git.latest:
    - target: /srv/zosia-server

salt-call --local state.apply > /var/log/salt.log:
  cron.present:
    - user: root
      - minute: 5
