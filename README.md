# devise_oauth2_providable

Rails3 engine that brings OAuth2 Provider support to your application.

http://tools.ietf.org/html/draft-ietf-oauth-v2-15

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

## Usage

```ruby
class User
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

