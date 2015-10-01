# esa-ruby
[![Build Status](https://travis-ci.org/esaio/esa-ruby.svg)](https://travis-ci.org/esaio/esa-ruby)

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
# Initialization
client = Esa::Client.new(access_token: "<access_token>", current_team: 'foo')

# Team API
client.teams
#=> GET /v1/teams

client.team('bar')
#=> GET /v1/teams/bar

client.stats
#=> GET /v1/teams/bar/stats

# Post API
client.posts
#=> GET /v1/teams/foo/posts

client.posts(q: 'in:help')
#=> GET /v1/teams/foo/posts?q=in%3Ahelp

client.current_team = 'foobar'
post_number = 1
client.post(post_number)
#=> GET /v1/teams/foobar/posts/1

client.create_post(name: 'foo')
#=> POST /v1/teams/foobar/posts

client.update_post(post_number, name: 'bar')
#=> PATCH /v1/teams/foobar/posts/1

client.delete_post(post_number)
#=> DELETE /v1/teams/foobar/posts/1


# Comment API
client.comments(post_number)
#=> GET /v1/teams/foobar/posts/1/comments

client.create_comment(post_number, body_md: 'baz')
#=> POST /v1/teams/foobar/posts/1/comments

comment_id = 123
client.comment(comment_id)
#=> GET /v1/teams/foobar/comments/123

client.update_comment(comment_id, body_md: 'bazbaz')
#=> PATCH /v1/teams/foobar/comments/123

client.delete_comment(comment_id)
#=> DELETE /v1/teams/foobar/comments/123


# Upload Attachment(beta)
client.upload_attachment('/Users/foo/Desktop/foo.png')              # Path
client.upload_attachment(File.open('/Users/foo/Desktop/foo.png'))   # File
client.upload_attachment('http://example.com/foo.png')              # URL

```


see also: [dev/api/v1(beta) - docs.esa.io](https://docs.esa.io/posts/102)

## Contributing

1. Fork it ( https://github.com/esaio/esa-ruby/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
