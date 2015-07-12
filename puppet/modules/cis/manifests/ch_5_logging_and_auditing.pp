# == Class: cis::ch_5_logging_and_auditing
#
class cis::ch_5_logging_and_auditing {

  # 5.1.3 Configure /etc/rsyslog.conf (Not Scored)
  augeas { 'cis_5_1_3':
    context => '/files/etc/rsyslog.conf',
    changes => [
      'defnode messages entry[action/file = "/var/log/messages"] ""',
      'rm $messages/selector',
      'ins selector before $messages/action',
      'set $messages/selector/facility[1] auth',
      'set $messages/selector/facility[2] user',
      'set $messages/selector/level *',

      'defnode kern entry[action/file = "/var/log/kern.log"] ""',
      'set $kern/selector/facility kern',
      'set $kern/selector/level *',
      'set $kern/action/file /var/log/kern.log',

      'defnode daemon entry[action/file = "/var/log/daemon.log"] ""',
      'set $daemon/selector/facility daemon',
      'set $daemon/selector/level *',
      'set $daemon/action/file /var/log/daemon.log',

      'defnode syslog entry[action/file = "/var/log/syslog"] ""',
      'set $syslog/selector/facility syslog',
      'set $syslog/selector/level *',
      'set $syslog/action/file /var/log/syslog',

      'defnode unused entry[action/file = "/var/log/unused.log"] ""',
      'set $unused/selector/facility[1] lpr',
      'set $unused/selector/facility[2] news',
      'set $unused/selector/facility[3] uucp',
      'set $unused/selector/facility[4] local0',
      'set $unused/selector/facility[5] local1',
      'set $unused/selector/facility[6] local2',
      'set $unused/selector/facility[7] local3',
      'set $unused/selector/facility[8] local4',
      'set $unused/selector/facility[9] local5',
      'set $unused/selector/facility[10] local6',
      'set $unused/selector/level *',
      'set $unused/action/file /var/log/unused.log',
    ],
  }

  # 5.1.4 Create and Set Permissions on rsyslog Log Files (Scored)
  $log_files = [
    '/var/log/messages',
    '/var/log/secure',
    '/var/log/maillog',
    '/var/log/cron',
    '/var/log/spooler',
    '/var/log/kern.log',
    '/var/log/boot.log',
    '/var/log/syslog',
    '/var/log/unused.log',
  ]
  file { $log_files:
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0600',
  }

  # 5.1.5 Configure rsyslog to Send Logs to a Remote Log Host (Scored)
  # [Not implemented]

  # 5.2.1.1 Configure Audit Log Storage Size (Not Scored)
  # 5.2.1.2 Disable System on Audit Log Full (Not Scored)
  # 5.2.1.3 Keep All Auditing Information (Scored)
  augeas { 'cis_5_2_1':
    context => '/files/etc/audit/auditd.conf',
    changes => [
      'set max_log_file 6', # 5.2.1.1
      'set space_left_action email', # 5.2.1.2
      'set action_mail_acct root', # 5.2.1.2
      'set admin_space_left_action halt', # 5.2.1.2
      'set max_log_file_action keep_logs', # 5.2.1.3
    ],
  }

  # 5.2.4 Record Events That Modify Date and Time Information (Scored)
  # 5.2.5 Record Events That Modify User/Group Information (Scored)
  # 5.2.6 Record Events That Modify the System's Network Environment (Scored)
  # 5.2.7 Record Events That Modify the System's Mandatory Access Controls (Scored)
  # 5.2.8 Collect Login and Logout Events (Scored)
  # 5.2.9 Collect Session Initiation Information (Scored)
  # 5.2.10 Collect Discretionary Access Control Permission Modification Events (Scored)
  # 5.2.11 Collect Unsuccessful Unauthorized Access Attempts to Files (Scored)
  # 5.2.13 Collect Successful File System Mounts (Scored)
  # 5.2.14 Collect File Deletion Events by User (Scored)
  # 5.2.15 Collect Changes to System Administration Scope (sudoers) (Scored)
  # 5.2.16 Collect System Administrator Actions (sudolog) (Scored)
  # 5.2.17 Collect Kernel Module Loading and Unloading (Scored)
  # 5.2.18 Make the Audit Configuration Immutable (Scored)
  file { '/etc/audit/audit.rules':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0640',
    source => 'puppet:///modules/cis/etc/audit/audit.rules',
  }

  # 5.3 Configure logrotate (Not Scored)
  file { '/etc/logrotate.d/syslog':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/cis/etc/logrotate.d/syslog',
  }
}
