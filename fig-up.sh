curl -sSL https://get.docker.io/ubuntu/ | sh
echo DOCKER_OPTS=\"--bip=172.17.42.1/16 --dns=172.17.42.1\" >> /etc/default/docker
curl -L https://github.com/docker/fig/releases/download/0.5.2/linux > /usr/local/bin/fig
chmod +x /usr/local/bin/fig
service docker restart
git clone https://github.com/rattermeyer/vagrant-ci.git jenkins-ci && cd jenkins-ci && git checkout docker-skydns
