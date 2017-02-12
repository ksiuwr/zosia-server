{% from "nginx/map.jinja" import nginx with context %}

nginx_firewall_pkgs:
  pkg.installed:
    - name: firewalld

    # NOTE: Bugs here. Be sure to manually check if it applied correctly
nginx_firewall_zone:
  firewalld.present:
    - name: public
    - block_icmp:
      - echo-reply
      - echo-request
    - ports:
      - 22/tcp
      - 80/tcp
{% if nginx.use_https %}
      - 443/tcp
{% endif %}
    - require:
        - pkg: firewalld
