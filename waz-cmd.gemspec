# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "waz-cmd/version"

Gem::Specification.new do |s|
  s.name        = "waz-cmd"
  s.version     = Waz::Cmd::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Steve Marx"]
  s.email       = ["Steve.Marx@microsoft.com"]
  s.homepage    = "http://github.com/smarx/waz-cmd"
  s.summary     = %q{Command-line tool to manage Windows Azure applications and storage accounts.}
  s.description = %q{This gem allows you to perform most of the available operations in the Windows Azure Service Management API from a friendly commandline tool.}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency('commander', '4.0.4')
  s.add_dependency('tilt')
  s.add_dependency('crack')
  s.add_dependency('nokogiri')
  s.add_dependency('waz-storage')
  s.add_dependency('uuidtools')
end
