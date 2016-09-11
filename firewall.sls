firewalld:
    pkg.installed

public-firewall:
  firewalld.present:
    - name: public
    - block_icmp:
      - echo-reply
      - echo-request
    - ports:
      - 22/tcp
      - 80/tcp
    - require:
        - pkg: firewalld

restart-public-firewalld:
  service.running:
    - name: firewalld
    - user: root
    - onchanges:
        - public-firewall
