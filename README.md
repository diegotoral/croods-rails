[![CircleCI](https://circleci.com/gh/SeasonedSoftware/croods-rails.svg?style=svg)](https://circleci.com/gh/SeasonedSoftware/croods-rails)
[![Maintainability](https://api.codeclimate.com/v1/badges/5531c26549b427684578/maintainability)](https://codeclimate.com/github/SeasonedSoftware/croods-rails/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/5531c26549b427684578/test_coverage)](https://codeclimate.com/github/SeasonedSoftware/croods-rails/test_coverage)

# Croods
Short description and motivation.

## Usage

### Authentication
Croods uses [devise_token_auth](https://github.com/lynndylanhurley/devise_token_auth) under the hood.
To customize which devise modules are loaded, you can pass them as arguments to `use_for_authentication!`
```
use_for_authentication!(
  :database_authenticatable,
  :recoverable,
  :rememberable,
  :trackable,
  :validatable
)
```
## Installation
Add this line to your application's Gemfile:

```ruby
gem 'croods'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install croods
```


## Contributing

You can manually check your changes in the dummy Rails app under `/todos`.

To set it up:
```
cd todos/
bin/setup
```

To run specs use:
```bin/rspec```

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

