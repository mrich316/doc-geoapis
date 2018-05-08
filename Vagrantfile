# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  config.vm.box = "ubuntu/xenial64"
  config.vm.network "forwarded_port", guest: 8080, host: 8080

  config.vm.provider "virtualbox" do |v|
    v.memory = 1024
  end

  config.vm.provision "docker", run: "always" do |docker|
    docker.build_image "/vagrant/", args: "--tag docker-registry-dev.laval.ca/doc_geoapis"
  end

  config.vm.provision "docker", run: "always" do |docker|
    docker.run "docker-registry-dev.laval.ca/doc_geoapis",
      args: "-p 8080:80 --name doc_geoapis",
      auto_assign_name: false
  end

  config.vm.provision "run",
    type: "shell",
    privileged: false,
    run: "always",
    inline: <<-SHELL

    echo "=============================================="
    echo "Open a browser at http://localhost:8080/"
    echo "To push a new version (you need git installed):"
    echo "/vagrant/docker-build_and_push.sh"
    echo "=============================================="

  SHELL

end