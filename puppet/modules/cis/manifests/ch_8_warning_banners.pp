# == Class: cis::ch_8_warning_banners
#
class cis::ch_8_warning_banners {

  # 8.1 Set Warning Banner for Standard Login Services (Scored)
  # 8.2 Remove OS Information from Login Warning Banners (Scored)
  file { ['/etc/motd', '/etc/issue', '/etc/issue.net']:
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => "Authorized uses only. All activity may be monitored and reported.\n",
  }

  # 8.3 Set GNOME Warning Banner (Not Scored)
  # [GNOME is installed]
}
