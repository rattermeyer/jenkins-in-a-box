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
	