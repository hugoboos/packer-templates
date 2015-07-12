# == Class: cis::ch_3_special_purpose_services
#
class cis::ch_3_special_purpose_services {

  # 3.1 Set Daemon umask (Scored)
  augeas { 'cis_3_1':
    context => '/files/etc/sysconfig/init',
    changes => 'set umask 027',
  }

  # 3.6 Configure Network Time Protocol (NTP) (Scored)
  package { 'ntp':
    ensure => present,
  }
}
