# == Class: vagrant
#
class vagrant {

  include ::vagrant::user
  include ::vagrant::tweaks
}
