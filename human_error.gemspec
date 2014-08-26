# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'human_error/version'

Gem::Specification.new do |gem|
  gem.rubygems_version  = '1.3.5'

  gem.name              = 'human_error'
  gem.rubyforge_project = 'human_error'

  gem.version           = HumanError::VERSION
  gem.platform          = Gem::Platform::RUBY

  gem.authors           = %w{jfelchner}
  gem.email             = 'accounts+git@thekompanee.com'
  gem.date              = Time.now
  gem.homepage          = 'https://github.com/thekompanee/human_error'

  gem.summary           = %q{Common Error Extensions and Helpers}
  gem.description       = %q{}

  gem.rdoc_options      = ['--charset = UTF-8']
  gem.extra_rdoc_files  = %w{README.md}

  gem.executables       = Dir['{bin}/**/*'].map {|dir| dir.gsub!(/\Abin\//, '')}
  gem.files             = Dir['{app,config,db,lib}/**/*'] + %w{Rakefile README.md}
  gem.test_files        = Dir['{test,spec,features}/**/*']
  gem.require_paths     = ['lib']

  gem.add_development_dependency  'rspec',                        '~> 3.0'
  gem.add_development_dependency  'rspectacular',                 '~> 0.50'
  gem.add_development_dependency  'codeclimate-test-reporter',    '~> 0.3.0'
end
