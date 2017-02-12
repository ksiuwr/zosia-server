{% from "salt_minion/map.jinja" import salt_minion with context %}

{% if salt_minion.sync %}
salt_minion_repo:
  git.latest:
    - name: {{ salt_minion.repository_url }}
    - branch: {{ salt_minion.repository_branch }}
    - target: /srv/zosia-server
{% endif %}


salt_minion_systemd_service:
  file.managed:
    - name: /etc/systemd/system/salt_minion.service
    - source: salt://salt_minion/files/service.jinja
    - template: jinja

{% if salt_minion.sync and salt_minion.periodical_sync %}
systemctl start salt_minion:
  cron.present:
    - identifier: GIT_CONFIG_SYNC
    - user: root
    - minute: '*/15'
{% endif %}

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
    - mode: 600
