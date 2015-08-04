require 'rainbow'
require 'puppet-lint/tasks/puppet-lint'
require 'puppet-syntax/tasks/puppet-syntax'

Rake::Task[:lint].clear

task :default => ['packer:validate', 'puppet:syntax', 'puppet:lint']

namespace :packer do
  desc 'Validate the packer templates'
  task :validate do
    Dir.glob('templates/*.json').sort.each do |template|
      puts Rainbow("Validating '#{template}'...").green
      unless system "packer validate #{template}"
        fail "#{template} is not valid"
      end
    end
  end
end

namespace :puppet do
  desc 'Check the Puppet syntax'
  task :syntax  do
    Dir.chdir 'puppet'
    Rake::Task[:syntax].invoke
    Dir.chdir '..'
  end

  PuppetLint::RakeTask.new :lint do |config|
    config.pattern = 'puppet/**/*.pp'
    config.fail_on_warnings = true
    config.with_context = true
  end
end
