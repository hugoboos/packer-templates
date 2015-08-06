# == Class: vagrant::tweaks
#
class vagrant::tweaks {

  # Speed up SSH
  augeas { 'ssh_no_dns':
    context => '/files/etc/ssh/sshd_config',
    changes => 'set UseDNS no',
  }

  # Only start one TTY, instead of six
  augeas { 'one_tty':
    context => '/files/etc/sysconfig/init',
    changes => 'set ACTIVE_CONSOLES /dev/tty1',
  }

  # Fix slow DNS (https://www.netroby.com/view.php?id=3695)
  augeas { 'fix_slow_dns':
    context => '/files/etc/sysconfig/network',
    changes => 'set RES_OPTIONS single-request-reopen',
  }

  # Immediately boot the kernel
  # Display the boot messages
  augeas { 'speedup_booting':
    context => '/files/boot/grub/grub.conf',
    changes => [
      'set timeout 0',
      'rm title/kernel/rhgb',
    ],
  }

  # Fix the piix4_smbus error
  # (http://fintastical.blogspot.nl/2010/11/virtualbox-piix4smbus-error.html)
  augeas { 'blacklist_i2c_piix4':
    context => '/files/etc/modprobe.d/blacklist.conf',
    onlyif  => 'match blacklist[. = "i2c_piix4"] size == 0',
    changes => 'set blacklist[last()+1] i2c_piix4',
  }
}
