# == Class: cis
#
# CIS CentOS Linux 6 Benchmark
# v1.1.0 - 03-02-2015
class cis {

  include ::cis::ch_1_install_updates_patches_and_additional_security_software
  include ::cis::ch_2_os_services
  include ::cis::ch_3_special_purpose_services
  include ::cis::ch_4_network_configuration_and_firewalls
  include ::cis::ch_5_logging_and_auditing
  include ::cis::ch_6_system_access_authentication_and_authorization
  include ::cis::ch_7_user_accounts_and_environment
  include ::cis::ch_8_warning_banners
  include ::cis::ch_9_system_maintenance
}
