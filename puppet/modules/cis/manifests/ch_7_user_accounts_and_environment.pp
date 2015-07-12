# == Class: cis::ch_7_user_accounts_and_environment
#
class cis::ch_7_user_accounts_and_environment {

  # 7.1.1 Set Password Expiration Days (Scored)
  # 7.1.2 Set Password Change Minimum Number of Days (Scored)
  # 7.1.3 Set Password Expiring Warning Days (Scored)
  augeas { 'cis_7_1':
    context => '/files/etc/login.defs',
    changes => [
      'set PASS_MAX_DAYS 90', # 7.1.1
      'set PASS_MIN_DAYS 7', # 7.1.2
      'set PASS_WARN_AGE 7', # 7.1.3
    ],
  }

  # 7.2 Disable System Accounts (Scored)
  augeas { 'cis_7_2':
    context => '/files/etc/passwd',
    changes => 'set vboxadd/shell /sbin/nologin',
  }

  # 7.3 Set Default Group for root Account (Scored)
  # [Done in cis::ch_6_system_access_authentication_and_authorization]
  # [See: 6.5 Restrict Access to the su Command (Scored)]

  # 7.4 Set Default umask for Users (Scored)
  ['/etc/bashrc', '/etc/profile'].each |$file| {
    exec { "cis_7_4_${file}":
      command => "/bin/sed -i -r 's/(umask)([ \\t]*)[0-9]+/umask 077/gi' ${file}",
      onlyif  => "/usr/bin/test $(/bin/grep -E -i 'umask[[:space:]]*[0-9]+' ${file} | /bin/grep -E -iv 'umask[[:space:]]*077' | /usr/bin/wc -l) -ne 0",
    }
  }

  # 7.5 Lock Inactive User Accounts (Scored)
  augeas { 'cis_7_5':
    context => '/files/etc/default/useradd',
    changes => 'set INACTIVE 35',
  }
}
