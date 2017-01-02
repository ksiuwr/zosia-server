# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = '2'.freeze

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.provider 'virtualbox' do |vb|
    vb.memory = 1024
  end
  config.vm.define :master do |master_config|
    master_config.vm.box = 'bento/ubuntu-16.04'
    master_config.vm.synced_folder '.', '/srv/zosia-server'
    master_config.vm.synced_folder 'test/pillar/', '/srv/pillar'
    master_config.vm.synced_folder 'test/salt/', '/etc/salt'

    master_config.vm.provision :salt do |salt|
      salt.minion_config = 'etc/salt/minion'

      salt.install_type = 'stable'
      salt.install_master = true
      salt.no_minion = false
      salt.verbose = true
      salt.colorize = true
      salt.bootstrap_options = '-P -c /tmp'
    end
  end
end
