# == Class: cis::ch_3_special_purpose_services
#
class cis::ch_3_special_purpose_services {

  # 3.1 Set Daemon umask (Scored)
  augeas { 'cis_3_1':
    context => '/files/etc/sysconfig/init',
    changes => 'set umask 027',
  }

  # 3.2 Remove X Windows (Scored)
  augeas { 'cis_3_2':
    context => '/files/etc/inittab',
    changes => 'set id/runlevels 3',
  }

  # 3.2 Remove X Windows (Scored)
  # 3.5 Remove DHCP Server (Scored)
  # 3.7 Remove LDAP (Not Scored)
  # 3.9 Remove DNS Server (Not Scored)
  # 3.10 Remove FTP Server (Not Scored)
  # 3.11 Remove HTTP Server (Not Scored)
  # 3.12 Remove Dovecot (IMAP and POP3 services) (Not Scored)
  # 3.13 Remove Samba (Not Scored)
  # 3.14 Remove HTTP Proxy Server (Not Scored)
  # 3.15 Remove SNMP Server (Not Scored)
  $packages = [
    'xorg-x11-server-common', # 3.2
    'dhcp', # 3.5
    'openldap-servers', # 3.7
    'openldap-clients', # 3.7
    'bind', # 3.9
    'vsftpd', # 3.10
    'httpd', # 3.11
    'dovecot', # 3.12
    'samba', # 3.13
    'squid', # 3.14
    'net-snmp', # 3.15
  ]

  package { $packages:
    ensure => absent,
  }

  # 3.3 Disable Avahi Server (Scored)
  # 3.4 Disable Print Server - CUPS (Not Scored)
  # 3.8 Disable NFS and RPC (Not Scored)
  $services = [
    'avahi-daemon', # 3.3
    'cups', # 3.4
    'nfslock', # 3.8
    'rpcgssd', # 3.8
    'rpcbind', # 3.8
    'rpcidmapd', # 3.8
    'rpcsvcgssd', # 3.8
  ]

  service { $services:
    ensure => stopped,
    enable => false,
  }

  # 3.3 Disable Avahi Server (Scored)
  augeas { 'cis_3_3':
    context => '/files/etc/sysconfig/network',
    changes => 'set NOZEROCONF yes',
  }

  # 3.6 Configure Network Time Protocol (NTP) (Scored)
  package { 'ntp':
    ensure => present,
  }

  # 3.6 Configure Network Time Protocol (NTP) (Scored)
  augeas { 'cis_3_6_conf':
    context => '/files/etc/ntp.conf',
    changes => [
      'defvar restrict restrict[. = "default"]',
      'rm $restrict/action',
      'setm $restrict action[1] kod',
      'setm $restrict action[2] nomodify',
      'setm $restrict action[3] notrap',
      'setm $restrict action[4] nopeer',
      'setm $restrict action[5] noquery',
    ],
  }

  # 3.6 Configure Network Time Protocol (NTP) (Scored)
  augeas { 'cis_3_6_ntpd':
    context => '/files/etc/sysconfig/ntpd',
    changes => 'set OPTIONS \'"-u sntp:ntp -p /var/run/ntpd.pid -g"\'',
  }

  # 3.16 Configure Mail Transfer Agent for Local-Only Mode (Scored)
  # 4.4.2 Disable IPv6 (Not Scored)
  augeas { 'cis_3_16':
    context => '/files/etc/postfix/main.cf',
    changes => [
      'set inet_interfaces localhost', # 3.16
      'set inet_protocols ipv4', # 4.4.2
    ],
  }
}
