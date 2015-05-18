# esa-ruby

[WIP] esa API v1 client library, written in Ruby

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'esa'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install esa

## Usage

```ruby
client = Esa::Client.new(access_token: "<access_token>", current_team: 'foo')
client.teams
#=> GET /v1/teams

client.team('bar')
#=> GET /v1/teams/bar

client.posts
#=> GET /v1/teams/foo/posts

client.posts(q: 'in:help')
#=> GET /v1/teams/docs/posts?q=in%3Ahelp

client.current_team = 'foobar'
client.post(1)
#=> GET /v1/teams/foobar/posts/1

client.update_post(1, name: 'baz')
#=> PATCH /v1/teams/foobar/posts/1

client.delete_post(1)
#=> DELETE /v1/teams/foobar/posts/1
```

## Contributing

1. Fork it ( https://github.com/esaio/esa-ruby/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
