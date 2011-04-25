# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "devise_oauth2_token_bearer_authenticatable/version"

Gem::Specification.new do |s|
  s.name        = "devise_oauth2_token_bearer_authenticatable"
  s.version     = DeviseOauth2TokenBearerAuthenticatable::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Ryan Sonnek"]
  s.email       = ["ryan@socialcast.com"]
  s.homepage    = ""
  s.summary     = %q{TODO: Write a gem summary}
  s.description = %q{TODO: Write a gem description}

  s.rubyforge_project = "devise_oauth2_token_bearer_authenticatable"

  s.add_runtime_dependency(%q<devise>, ["~> 1.3.3"])
  s.add_runtime_dependency(%q<rack-oauth2>, ["~> 0.6.3"])

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
