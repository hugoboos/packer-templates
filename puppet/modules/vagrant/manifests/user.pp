# == Class: vagrant::user
#
class vagrant::user {

  file { '/home/vagrant/.ssh':
    ensure => directory,
    owner  => 'vagrant',
    group  => 'vagrant',
    mode   => '0700',
  }

  # Insecure public key
  file { '/home/vagrant/.ssh/authorized_keys':
    ensure  => file,
    owner   => 'vagrant',
    group   => 'vagrant',
    mode    => '0600',
    replace => false,
    source  => 'puppet:///modules/vagrant/home/vagrant/ssh/authorized_keys',
    require => File['/home/vagrant/.ssh'],
  }
}
