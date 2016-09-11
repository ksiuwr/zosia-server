firewalld:
    pkg.installed

public:
  firewalld.present:
    - name: public
    - block_icmp:
      - echo-reply
      - echo-request
    - ports:
      - 22/tcp
    - require:
        - pkg: firewalld

restart-public-firewalld:
  service.running:
    - name: firewalld
    - onchanges:
        - public
