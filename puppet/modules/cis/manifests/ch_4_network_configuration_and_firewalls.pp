# == Class: cis::ch_4_network_configuration_and_firewalls
#
class cis::ch_4_network_configuration_and_firewalls {

  # 4.1.1 Disable IP Forwarding (Scored)
  # 4.1.2 Disable Send Packet Redirects (Scored)
  # 4.2.1 Disable Source Routed Packet Acceptance (Scored)
  # 4.2.2 Disable ICMP Redirect Acceptance (Scored)
  # 4.2.3 Disable Secure ICMP Redirect Acceptance (Scored)
  # 4.2.4 Log Suspicious Packets (Scored)
  # 4.2.5 Enable Ignore Broadcast Requests (Scored)
  # 4.2.6 Enable Bad Error Message Protection (Scored)
  # 4.2.7 Enable RFC-recommended Source Route Validation (Scored)
  # 4.2.8 Enable TCP SYN Cookies (Scored)
  # 4.4.1.1 Disable IPv6 Router Advertisements (Not Scored)
  # 4.4.1.2 Disable IPv6 Redirect Acceptance (Not Scored)
  augeas { 'cis_4':
    context => '/files/etc/sysctl.conf',
    changes => [
      'set net.ipv4.ip_forward 0', # 4.1.1
      'set net.ipv4.conf.all.send_redirects 0', # 4.1.2
      'set net.ipv4.conf.default.send_redirects 0', # 4.1.2
      'set net.ipv4.conf.all.accept_source_route 0', # 4.2.1
      'set net.ipv4.conf.default.accept_source_route 0', # 4.2.1
      'set net.ipv4.conf.all.accept_redirects 0', # 4.2.2
      'set net.ipv4.conf.default.accept_redirects 0', # 4.2.2
      'set net.ipv4.conf.all.secure_redirects 0', # 4.2.3
      'set net.ipv4.conf.default.secure_redirects 0', # 4.2.3
      'set net.ipv4.conf.all.log_martians 1', # 4.2.4
      'set net.ipv4.conf.default.log_martians 1', # 4.2.4
      'set net.ipv4.icmp_echo_ignore_broadcasts 1', # 4.2.5
      'set net.ipv4.icmp_ignore_bogus_error_responses 1', # 4.2.6
      'set net.ipv4.conf.all.rp_filter 1', # 4.2.7
      'set net.ipv4.conf.default.rp_filter 1', # 4.2.7
      'set net.ipv4.tcp_syncookies 1', # 4.2.8
      'set net.ipv6.conf.all.accept_ra 0', # 4.4.1.1
      'set net.ipv6.conf.default.accept_ra 0', # 4.4.1.1
      'set net.ipv6.conf.all.accept_redirects 0', # 4.4.1.2
      'set net.ipv6.conf.default.accept_redirects 0', # 4.4.1.2
    ],
  }

  # 4.4.2 Disable IPv6 (Not Scored)
  augeas { 'cis_4.4.2':
    context => '/files/etc/sysconfig/network',
    changes => [
      'set NETWORKING_IPV6 no',
      'set IPV6INIT no',
    ],
  }

  # 4.4.2 Disable IPv6 (Not Scored)
  file { '/etc/modprobe.d/ipv6.conf':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0600',
    source => 'puppet:///modules/cis/etc/modprobe.d/ipv6.conf',
  }

  # 4.5.1 Install TCP Wrappers (Not Scored)
  package { 'tcp_wrappers':
    ensure => present,
  }

  # 4.5.2 Create /etc/hosts.allow (Not Scored)
  # 4.5.3 Verify Permissions on /etc/hosts.allow (Scored)
  file { '/etc/hosts.allow':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => "ALL: ALL\n",
  }

  # 4.5.4 Create /etc/hosts.deny (Not Scored)
  # 4.5.5 Verify Permissions on /etc/hosts.deny (Scored)
  file { '/etc/hosts.deny':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => "ALL: ALL\n",
  }

  # 4.6.1 Disable DCCP (Not Scored)
  # 4.6.2 Disable SCTP (Not Scored)
  # 4.6.3 Disable RDS (Not Scored)
  # 4.6.4 Disable TIPC (Not Scored)
  # [Done in cis::ch_1_install_updates_patches_and_additional_security_software]
  # [See resource '/etc/modprobe.d/cis.conf']
}
