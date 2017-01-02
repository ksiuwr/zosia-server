{% from "nginx/map.jinja" import nginx with context %}

include:
  - nginx.configure
  - nginx.firewall
{% if nginx.use_https %}
  - nginx.letsencrypt
{% endif %}
