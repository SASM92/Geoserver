# -*- mode: ruby -*-
# vi: set ft=ruby :

masterIP = "192.168.1.20"
masterFQDN = "Geoserver"

Vagrant.configure("2") do |config|

    config.vm.box = "chad-thompson/ubuntu-trusty64-gui"
	
	config.vm.define "master" do |master|
		master.vm.network :public_network, ip: masterIP
		master.vm.hostname = masterFQDN
		master.vm.synced_folder "shared", "/tmp/shared"
		master.vm.provision :shell, path: "bootstrap.sh" 
		
		
		master.vm.provider :virtualbox do |masterVM|
			masterVM.gui = true
			masterVM.name = "Geoserver"
			masterVM.memory = 4096
			masterVM.cpus = 2
		end
	end    

end