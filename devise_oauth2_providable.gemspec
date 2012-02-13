# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "devise/oauth2_providable/version"

Gem::Specification.new do |s|
  s.name        = "devise_oauth2_providable"
  s.version     = Devise::Oauth2Providable::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Ryan Sonnek"]
  s.email       = ["ryan@socialcast.com"]
  s.homepage    = ""
  s.summary     = %q{OAuth2 Provider for Rails3 applications}
  s.description = %q{Rails3 engine that adds OAuth2 Provider support to any application built with Devise authentication}

  s.rubyforge_project = "devise_oauth2_providable"

  s.add_runtime_dependency(%q<rails>, ["~> 3.1.0"])
  s.add_runtime_dependency(%q<devise>, [">= 1.4.3"])
  s.add_runtime_dependency(%q<rack-oauth2>, ["~> 0.11.0"])
  s.add_development_dependency(%q<rspec-rails>, ['2.6.1'])
  s.add_development_dependency(%q<sqlite3>, ['~> 1.3.4'])
  s.add_development_dependency(%q<shoulda-matchers>, ['1.0.0.beta3'])
  s.add_development_dependency(%q<pry>, ['0.9.6.2'])
  s.add_development_dependency(%q<factory_girl>, ['2.2.0'])
  s.add_development_dependency(%q<factory_girl_rspec>, ['0.0.1'])
  s.add_development_dependency(%q<rake>, ['0.9.2.2'])

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end

