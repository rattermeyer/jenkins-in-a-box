
include curl
package { 'git' : }->
package { 'python' : }->
curl::fetch { "download":
  source      => "https://github.com/docker/fig/releases/download/0.5.2/linux",
  destination => "/usr/local/bin/fig",
  timeout     => 0,
  verbose     => false,
}->
file { '/usr/local/bin/fig' :
  mode => '0755'
}->
class { 'docker':
  tcp_bind    => 'tcp://0.0.0.0:4243',
  socket_bind => 'unix:///var/run/docker.sock',
  dns		  => '172.17.42.1',
  extra_parameters => '-bip 172.17.42.1/16'
}->
docker::run { 'skydns' :
  image => 'crosbymichael/skydns',
  use_name => true,
  restart_service => false,
  ports   => '172.17.42.1:53:53/udp',
  command => '-nameserver 8.8.8.8:53 -domain docker',
}->
docker::run { 'skydock' :
  image => 'crosbymichael/skydock',
  use_name => true,
  restart_service => false,
  dns => ['8.8.8.8'],
  volumes => ['/var/run/docker.sock:/docker.sock'],
  command => '-ttl 30 -environment dev -s /docker.sock -domain docker -name skydns'
}->
vcsrepo { "/root/jenkinsci":
      ensure   => present,
      provider => git,
      source   => 'https://github.com/rattermeyer/vagrant-ci.git',
      revision => 'docker-skydns',
}->
exec { "start jenkinsci" :
	command => "/usr/sbin/service docker restart && /usr/local/bin/fig up -d",
	cwd => "/root/jenkinsci"
}