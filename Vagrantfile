$install_puppet = <<PUPPET
if [ ! $(rpm -qa | grep puppet-agent) ]; then
  echo "Installing Puppet..."
  yum -y -q install https://yum.puppetlabs.com/puppetlabs-release-pc1-el-6.noarch.rpm
  yum -y -q install puppet-agent
fi
PUPPET

Vagrant.require_version ">= 1.7.3"
Vagrant.configure(2) do |config|

  config.vm.define "centos-6.7-i686", autostart: false do |node|
    node.vm.box = "centos-6.7-i686"
    node.vm.box_url = "build/centos-6.7-i686.box"
  end

  config.vm.define "centos-6.7-x86_64", autostart: false do |node|
    node.vm.box = "centos-6.7-x86_64"
    node.vm.box_url = "build/centos-6.7-x86_64.box"
  end

  config.vm.provision "shell", upload_path: "/home/vagrant/install-puppet", inline: $install_puppet
  config.vm.provision "puppet" do |puppet|
    puppet.environment_path = "puppet/environments"
    puppet.module_path = "puppet/modules"
    puppet.environment = "packer"
  end
end
