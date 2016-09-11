#!/bin/bash

set -e

salt-call --local state.apply git_config_sync
salt-call --local state.apply
