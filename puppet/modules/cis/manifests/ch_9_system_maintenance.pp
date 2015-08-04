# == Class: cis::ch_9_system_maintenance
#
class cis::ch_9_system_maintenance {

  # 9.1.1 Verify System File Permissions (Not Scored)
  # [Not implemented]

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

  # 9.1.10 Find World Writable Files (Not Scored)
  # 9.1.11 Find Un-owned Files and Directories (Scored)
  # 9.1.12 Find Un-grouped Files and Directories (Scored)
  # 9.1.13 Find SUID System Executables (Not Scored)
  # 9.1.14 Find SGID System Executables (Not Scored)
  # [Not implemented]

  # 9.2.1 Ensure Password Fields are Not Empty (Scored)
  # 9.2.2 Verify No Legacy "+" Entries Exist in /etc/passwd File (Scored)
  # 9.2.3 Verify No Legacy "+" Entries Exist in /etc/shadow File (Scored)
  # 9.2.4 Verify No Legacy "+" Entries Exist in /etc/group File (Scored)
  # 9.2.5 Verify No UID 0 Accounts Exist Other Than root (Scored)
  # 9.2.6 Ensure root PATH Integrity (Scored)
  # 9.2.7 Check Permissions on User Home Directories (Scored)
  # 9.2.8 Check User Dot File Permissions (Scored)
  # 9.2.9 Check Permissions on User .netrc Files (Scored)
  # 9.2.10 Check for Presence of User .rhosts Files (Scored)
  # 9.2.11 Check Groups in /etc/passwd (Scored)
  # 9.2.12 Check That Users Are Assigned Valid Home Directories (Scored)
  # 9.2.13 Check User Home Directory Ownership (Scored)
  # 9.2.14 Check for Duplicate UIDs (Scored)
  # 9.2.15 Check for Duplicate GIDs (Scored)
  # 9.2.16 Check for Duplicate User Names (Scored)
  # 9.2.17 Check for Duplicate Group Names (Scored)
  # 9.2.18 Check for Presence of User .netrc Files (Scored)
  # 9.2.19 Check for Presence of User .forward Files (Scored)
  # [Not implemented]
}
