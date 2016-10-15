#!/bin/bash

set -e

curl -L https://bootstrap.saltstack.com -o bootstrap_salt.sh
# TODO: sha256sum validation
sudo sh bootstrap_salt.sh

sudo git clone https://github.com/ksiuwr/zosia-server.git /srv/zosia-server
sudo cp /srv/zosia-server/etc/salt/minion /etc/salt/minion
sudo salt-call --local state.apply
