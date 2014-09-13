# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "puppetlabs/ubuntu-14.04-64-puppet"
  config.vm.network :forwarded_port, guest: 3000, host: 3000
  # config.vm.network :private_network, ip: "192.168.33.10"
  # config.vm.network :public_network
  config.ssh.forward_agent = true
  config.vm.synced_folder "~/GitHub", "/GitHub"

  config.vm.provider "vmware_fusion" do |v|
    v.vmx["memsize"] = "2048"
    v.vmx["numvcpus"] = "4"
  end

  config.vm.provision :shell, path: "bootstrap.sh"
end