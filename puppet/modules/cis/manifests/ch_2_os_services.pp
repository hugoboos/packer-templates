# == Class: ch_2_os_services
#
class cis::ch_2_os_services {

  # 2.1.1 Remove telnet-server (Scored)
  # 2.1.2 Remove telnet Clients (Scored)
  # 2.1.3 Remove rsh-server (Scored)
  # 2.1.4 Remove rsh (Scored)
  # 2.1.5 Remove NIS Client (Scored)
  # 2.1.6 Remove NIS Server (Scored)
  # 2.1.7 Remove tftp (Scored)
  # 2.1.8 Remove tftp-server (Scored)
  # 2.1.9 Remove talk (Scored)
  # 2.1.10 Remove talk-server (Scored)
  # 2.1.11 Remove xinetd (Scored)
  $packages = [
    'telnet-server', # 2.1.1
    'telnet', # 2.1.2
    'rsh-server', # 2.1.3
    'rsh', # 2.1.4
    'ypbind', # 2.1.5
    'ypserv', # 2.1.6
    'tftp', # 2.1.7
    'tftp-server', # 2.1.8
    'talk', # 2.1.9
    'talk-server', # 2.1.10
    'xinetd', # 2.1.11
  ]

  package { $packages:
    ensure => absent,
  }

  # 2.1.12 Disable chargen-dgram (Scored)
  # 2.1.13 Disable chargen-stream (Scored)
  # 2.1.14 Disable daytime-dgram (Scored)
  # 2.1.15 Disable daytime-stream (Scored)
  # 2.1.16 Disable echo-dgram (Scored)
  # 2.1.17 Disable echo-stream (Scored)
  # 2.1.18 Disable tcpmux-server (Scored)
  $services = [
    'chargen-dgram', # 2.1.12
    'chargen-stream', # 2.1.13
    'daytime-dgram', # 2.1.14
    'daytime-stream', # 2.1.15
    'echo-dgram', # 2.1.16
    'echo-stream', # 2.1.17
    'tcpmux-server', # 2.1.18
  ]

  service { $services:
    ensure => stopped,
    enable => false,
  }
}
