firewalld:
    pkg.installed

    # NOTE: Bugs here. Be sure to manually check if it applied correctly
public:
  firewalld.present:
    - name: public
    - block_icmp:
      - echo-reply
      - echo-request
    - ports:
      - 22/tcp
      - 80/tcp
      - 443/tcp
    - require:
        - pkg: firewalld
