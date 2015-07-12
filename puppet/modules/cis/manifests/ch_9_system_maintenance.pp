# == Class: cis::ch_9_system_maintenance
#
class cis::ch_9_system_maintenance {

  # 9.1.2 Verify Permissions on /etc/passwd (Scored)
  # 9.1.5 Verify Permissions on /etc/group (Scored)
  # 9.1.6 Verify User/Group Ownership on /etc/passwd (Scored)
  # 9.1.9 Verify User/Group Ownership on /etc/group (Scored)
  file { ['/etc/passwd', '/etc/group']:
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }

  # 9.1.3 Verify Permissions on /etc/shadow (Scored)
  # 9.1.4 Verify Permissions on /etc/gshadow (Scored)
  # 9.1.7 Verify User/Group Ownership on /etc/shadow (Scored)
  # 9.1.8 Verify User/Group Ownership on /etc/gshadow (Scored)
  file { ['/etc/shadow', '/etc/gshadow']:
    owner => 'root',
    group => 'root',
    mode  => '0000',
  }
}
