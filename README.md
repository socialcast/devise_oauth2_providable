# devise_oauth2_token_bearer_authenticatable

Support OAuth2 authentication for your API.

http://tools.ietf.org/html/draft-ietf-oauth-v2-15

## Installation

```ruby
# Bundler Gemfile
gem 'oauth2_token_bearer_authenticatable'
```

```ruby
# create new Rails migration
class CreateOauth2Schema < ActiveRecord::Migration
  def self.up
    Devise::Oauth2TokenBearerAuthenticatable::Schema.up(self)
  end
  def self.down
    Devise::Oauth2TokenBearerAuthenticatable::Schema.down(self)
  end
end
```

## Usage

```ruby
class User
  devise :database_authenticatable, :oauth2_token_bearer_authenticatable
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

