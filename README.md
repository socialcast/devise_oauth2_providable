# devise_oauth2_providable

Rails3 engine that brings OAuth2 Provider support to your application.

## Features

* integrates OAuth2 authentication with Devise authenthentication stack
* 

## OAuth2
Current Specification Draft:
http://tools.ietf.org/html/draft-ietf-oauth-v2-15

### /oauth2/authorize Endpoint
http://tools.ietf.org/html/draft-ietf-oauth-v2-15#section-2.1

Endpoint to start client authorization flow.  Models, controllers and
views are included for out of the box deployment.

### /oauth2/token Endpoint
http://tools.ietf.org/html/draft-ietf-oauth-v2-15#section-2.2

Endpoint to request access token.  All grant types should be supported.

### Resource Owner Password Credentials Grant Type
http://tools.ietf.org/html/draft-ietf-oauth-v2-15#section-4.3

in order to use the Resource Owner Password Credentials Grant Type, your
Devise model *must* be configured to support the
:database_authenticatable option

### Implicit Grant Type
http://tools.ietf.org/html/draft-ietf-oauth-v2-15#section-4.2

### Refresh Token Grant Type
http://tools.ietf.org/html/draft-ietf-oauth-v2-15#section-6

### Bearer Tokens
http://tools.ietf.org/html/draft-ietf-oauth-v2-bearer-04

All server requests support authentication via bearer token included in
the request.

## Installation

```ruby
# Bundler Gemfile
gem 'devise_oauth2_providable'
```

```ruby
# create new Rails migration
class CreateOauth2Schema < ActiveRecord::Migration
  def self.up
    Devise::Oauth2Providable:Schema.up(self)
  end
  def self.down
    Devise::Oauth2Providable::Schema.down(self)
  end
end
```
```ruby
class User
  # NOTE: include :database_authenticatable configuration
  # if supporting Resource Owner Password Credentials Grant Type
  devise :oauth2_providable
end
```

## Contributing
 
* Fork the project
* Fix the issue
* Add unit tests
* Submit pull request on github

See CONTRIBUTORS.txt for list of project contributors

## Copyright

Copyright (c) 2011 Socialcast, Inc. 
See LICENSE.txt for further details.

