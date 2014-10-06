# Jenkins-in-a-Box
Jenkins-in-a-Box is an easy to install development / test environment for Jenkins administration.
It contains docker containers for nexus, sonar, jenkins, jenkins-slave all ready to go and easy to customize.

# Prerequisites
You need [Vagrant](http://www.vagrantup.com) installed on your system.

# Installation

	git clone https://github.com/rattermeyer/jenkins-in-a-box.git
	cd jenkins-in-a-box
	vagrant up
	
Installation takes (depending on internet connection) around 30-45 min.
You can check if everything is up and running
	vagrant ssh
	sudo docker ps | wc
The last command should print 

What *should* end up with is a VM with multiple docker containers

* git repository
* nexus repository
* jenkins master
* jenkins slave
* sonar
* skydns
* skydock

The latter two are for name resolution between docker containers.

Some other pre-requisite tasks:

* To enable sonar, you must first access sonar: http://localhost:9000 
* Check nexus: http://localhost:8081/nexus
* Access Jenkins: http://localhost:8080/jenkins

# Known Issues
## Name Resolution not working
Currently skydns has a TTL for entries of standard 3600s. So after one hour the system will not be able to work correctly because docker container cannot resolve of other
containers anymore. 
This can easily be resolved by running

	docker stop skydock
	docker start skydock

The skydock container will automatically add all running containers to the SkyDNS service.

## Jenkins slave not showing up
Solution: restart slave

	# enter VM
	vagrant ssh
	# become root
	sudo -s
	# switch to project base dir
	cd /root/jenkinsci
	fig stop slave
	fig start slave
	
## You want to test with more than one slave
Solution: `fig scale slave=2` (replace 2 with any number. Determines number of running instances) 
	