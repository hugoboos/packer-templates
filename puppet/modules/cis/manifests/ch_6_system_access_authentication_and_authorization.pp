# == Class: cis::ch_6_system_access_authentication_and_authorization
#
class cis::ch_6_system_access_authentication_and_authorization {

  # 6.1.1 Enable anacron Daemon (Scored)
  package { 'cronie-anacron':
    ensure => present,
  }

  # 6.1.2 Enable crond Daemon (Scored)
  service { 'crond':
    ensure => running,
    enable => true,
  }

  # 6.1.3 Set User/Group Owner and Permission on /etc/anacrontab (Scored)
  # 6.1.4 Set User/Group Owner and Permission on /etc/crontab (Scored)
  file { ['/etc/crontab', '/etc/anacrontab']:
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0600',
  }

  # 6.1.5 Set User/Group Owner and Permission on /etc/cron.hourly (Scored)
  # 6.1.6 Set User/Group Owner and Permission on /etc/cron.daily (Scored)
  # 6.1.7 Set User/Group Owner and Permission on /etc/cron.weekly (Scored)
  # 6.1.8 Set User/Group Owner and Permission on /etc/cron.monthly (Scored)
  # 6.1.9 Set User/Group Owner and Permission on /etc/cron.d (Scored)
  $cron_directories = [
    '/etc/cron.hourly',
    '/etc/cron.daily',
    '/etc/cron.weekly',
    '/etc/cron.monthly',
    '/etc/cron.d',
  ]
  file { $cron_directories:
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0700',
    recurse => true,
  }

  # 6.1.10 Restrict at Daemon (Scored)
  # 6.1.11 Restrict at/cron to Authorized Users (Scored)
  file { ['/etc/at.deny', '/etc/cron.deny']:
    ensure => absent,
  }

  # 6.1.10 Restrict at Daemon (Scored)
  # 6.1.11 Restrict at/cron to Authorized Users (Scored)
  file { ['/etc/at.allow', '/etc/cron.allow']:
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0600',
  }

  # 6.2.1 Set SSH Protocol to 2 (Scored)
  # 6.2.2 Set LogLevel to INFO (Scored)
  # 6.2.4 Disable SSH X11 Forwarding (Scored)
  # 6.2.5 Set SSH MaxAuthTries to 4 or Less (Scored)
  # 6.2.6 Set SSH IgnoreRhosts to Yes (Scored)
  # 6.2.7 Set SSH HostbasedAuthentication to No (Scored)
  # 6.2.8 Disable SSH Root Login (Scored)
  # 6.2.9 Set SSH PermitEmptyPasswords to No (Scored)
  # 6.2.10 Do Not Allow Users to Set Environment Options (Scored)
  # 6.2.11 Use Only Approved Cipher in Counter Mode (Scored)
  # 6.2.12 Set Idle Timeout Interval for User Login (Scored)
  # 6.2.14 Set SSH Banner (Scored)
  augeas { 'cis_6_2':
    context => '/files/etc/ssh/sshd_config',
    changes => [
      'set Protocol 2', # 6.2.1
      'set LogLevel INFO', # 6.2.2
      'set X11Forwarding no', # 6.2.4
      'set MaxAuthTries 4', # 6.2.5
      'set IgnoreRhosts yes', # 6.2.6
      'set HostbasedAuthentication no', # 6.2.7
      'set PermitRootLogin no', # 6.2.8
      'set PermitEmptyPasswords no', # 6.2.9
      'set PermitUserEnvironment no', # 6.2.10
      'set Ciphers/1 aes128-ctr', # 6.2.11
      'set Ciphers/2 aes192-ctr', # 6.2.11
      'set Ciphers/3 aes256-ctr', # 6.2.11
      'set ClientAliveInterval 300', # 6.2.12
      'set ClientAliveCountMax 0', # 6.2.12
      'set Banner /etc/issue.net', # 6.2.14
    ],
  }

  # 6.2.13 Limit Access via SSH (Scored)
  # [Not implemented]

  # 6.3.1 Upgrade Password Hashing Algorithm to SHA-512 (Scored)
  exec { 'cis_6_3_1':
    command => '/usr/sbin/authconfig --passalgo=sha512 --update',
    onlyif  => '/usr/sbin/authconfig --test | /bin/grep hashing | /bin/grep -v sha512',
  }

  # 6.3.2 Set Password Creation Requirement Parameters Using pam_cracklib (Scored)
  augeas { 'cis_6_3_2':
    context => '/files/etc/pam.d/system-auth-ac/*[type="password" and module="pam_cracklib.so"]',
    changes => [
      'set control required',
      'set argument[1] try_first_pass',
      'set argument[2] retry=3',
      'set argument[3] minlen=14',
      'set argument[4] dcredit=-1',
      'set argument[5] ucredit=-1',
      'set argument[6] ocredit=-1',
      'set argument[7] lcredit=-1',
    ],
  }

  # 6.3.3 Set Lockout for Failed Password Attempts (Not Scored)
  # [Not implemented]

  # 6.3.4 Limit Password Reuse (Scored)
  $pam_unix_context = '/files/etc/pam.d/system-auth-ac/*[type="password" and module="pam_unix.so"]'
  augeas { 'cis_6_3_4':
    context => $pam_unix_context,
    onlyif  => "match ${pam_unix_context}[argument='remember=5'] size == 0",
    changes => 'set argument[last()+1] remember=5',
  }

  # 6.4 Restrict root Login to System Console (Not Scored)
  file { '/etc/securetty':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    content => "tty1\n",
  }

  # 6.5 Restrict Access to the su Command (Scored)
  augeas { 'cis_6_5':
    context => '/files/etc/pam.d/su',
    onlyif  => 'match *[type="auth" and control="required" and module="pam_wheel.so" and argument="use_uid"] size  ==  0',
    changes => [
      'ins 01 after *[type="auth" and control="sufficient" and module="pam_rootok.so"][last()]',
      'set 01/type auth',
      'set 01/control required',
      'set 01/module pam_wheel.so',
      'set 01/argument use_uid',
    ],
  }

  # 6.5 Restrict Access to the su Command (Scored)
  # 7.3 Set Default Group for root Account (Scored)
  user { 'root':
    gid    => 0,
    groups => ['root', 'wheel'],
  }
}
