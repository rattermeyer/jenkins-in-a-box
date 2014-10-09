# vim: set autoindent ft=ruby : 
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "yungsang/boot2docker"
  config.vm.network "forwarded_port", guest: 8080, host: 8080
  config.vm.network "forwarded_port", guest: 8081, host: 8081
  config.vm.network "forwarded_port", guest: 9000, host: 9000
  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--memory", "8192"]
	vb.customize ["modifyvm", :id, "--cpus", "4"]
  end
  config.vm.provision "shell",
	inline: "echo EXTRA_ARGS=--dns 172.17.46.1 > /var/lib/boot2docker/profile"
  config.vm.provision "shell",
	inline: "tce-load -wi python-dev.tcz"
  config.vm.provision "docker" do |d|
	d.run "crosbymichael/skydns",
		cmd: "-p 172.17.42.1:53:53/udp --name skydns crosbymichael/skydns -nameserver 8.8.8.8:53 -domain docker"
	d.run "crosbymichael/skydock",
		cmd: "-v /var/run/docker.sock:/docker.sock --name skydock crosbymichael/skydock -ttl 30 -environment dev -s /docker.sock -domain docker -name skydns"
  end
end
