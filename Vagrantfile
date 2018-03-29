# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  config.vm.box = "ubuntu/xenial64"
  config.vm.network "forwarded_port", guest: 8080, host: 8080

  config.vm.provider "virtualbox" do |v|
    v.memory = 1024
  end

  config.vm.provision "docker", run: "always" do |docker|
    docker.build_image "/vagrant/", args: "--tag testgeo1.laval.ca/doc_api"
  end

  config.vm.provision "docker", run: "always" do |docker|
    docker.run "testgeo1.laval.ca/doc_api",
      args: "-p 8080:80 --name doc_api",
      auto_assign_name: false
  end

  config.vm.provision "run",
    type: "shell",
    privileged: false,
    run: "always",
    inline: <<-SHELL

    echo "=============================================="
    echo "Open a browser at http://localhost:8080/"
    echo "To push a new version:"
    echo "docker build -t testgeo1.laval.ca/doc_api ."
    echo "docker push testgeo1.laval.ca/doc_api"
    echo "To update the service on cdocmgr2:"
    echo "SSH on cdocmgr2:"
    echo "docker service update --force --image testgeo1.laval.ca/doc_api doc_api"
    echo "=============================================="

  SHELL

end