# mcjsonapi [![Build Status](https://api.travis-ci.org/elomatreb/mcjsonapi.svg?branch=dev)](https://travis-ci.org/elomatreb/mcjsonapi)

This rubygem provides an easy way to interact with a [Minecraft](https://minecraft.net) ([bukkit](https://bukkit.org/)) server running the [JSONAPI plugin](https://github.com/alecgorge/jsonapi). It uses the v2-API, so it has full support for permissions.

Calling multiple methods is not yet implemented, but is planned for the 1.0 release.

## Installation

Add this line to your application's `Gemfile`:
```
gem 'mcjsonapi', '~> 0.9.0'
```
(Don't forget to run `$ bundle install`)

Or install it manually:
```
$ gem install mcjsonapi
```
## Usage
```ruby
require "mcjsonapi"

# Create a new API instance
api = Mcjsonapi::API.new username: "username", password: "password", host: "localhost", port: 20059 # localhost:20059 is assumed as default host

# Call a single method
api.call "server.version"
# => "git-Bukkit-1.6.4-R2.0-b2918jnks (MC: 1.6.4)"

# Call a method with arguments
api.call { name: "players.online.send_message", arguments: ["Player", "Hello World"] }

# Generate a call key
api.generate_key("server.version")
# => "8433478ce05d331c743ff69cad00792039396d222d304545bd40f2ccecd714c9"
    
# Calling multiple methods at once is not yet implemented.
```

## License

This project is available under the permissive [MIT license](http://opensource.org/licenses/MIT). (See [LICENSE.md](LICENSE.md) for details).
Any type of contribution is appreciated.
