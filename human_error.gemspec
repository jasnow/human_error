# encoding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'human_error/version'

Gem::Specification.new do |spec|
  spec.name          = 'human_error'
  spec.version       = HumanError::VERSION
  spec.authors       = ['jfelchner']
  spec.email         = 'accounts+git@thekompanee.com'
  spec.summary       = %q{Common Error Extensions and Helpers}
  spec.description   = %q{}
  spec.homepage      = 'https://github.com/thekompanee/human_error'
  spec.license       = 'MIT'

  spec.executables   = Dir['{bin}/**/*'].map    {|dir| dir.gsub!(/\Abin\//, '')}.
                                         reject {|bin| %w{rails rspec rake setup deploy}}
  spec.files         = Dir['{app,config,db,lib}/**/*'] + %w{Rakefile README.md LICENSE}
  spec.test_files    = Dir['{test,spec,features}/**/*']

  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'activerecord'
  spec.add_development_dependency 'overcommit'
  spec.add_development_dependency 'actionpack'
end
