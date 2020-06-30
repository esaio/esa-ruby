# esa-ruby
[![Build Status](https://github.com/esaio/esa-ruby/workflows/build/badge.svg)](https://github.com/esaio/esa-ruby/actions)


esa API v1 client library, written in Ruby

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

# Authenticated User API
client.user
#=> GET /v1/user

# Team API
client.teams
#=> GET /v1/teams

client.team('bar')
#=> GET /v1/teams/bar

client.stats
#=> GET /v1/teams/bar/stats

client.members
#=> GET /v1/teams/bar/members

screen_name = 'alice'
client.delete_member(screen_name)
#=> DELETE /v1/teams/bar/members/alice

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

# (beta)
client.append_post(post_number, content: 'bar')
#=> POST /v1/teams/foobar/posts/1/append

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

client.comments
#=> GET /v1/teams/foobar/comments

client.create_sharing(post_number)
#=> POST /v1/teams/foobar/posts/1/sharing

client.delete_sharing(post_number)
#=> DELETE /v1/teams/foobar/posts/1/sharing


# Star API
client.post_stargazers(post_number)
#=> GET /v1/teams/foobar/posts/1/stargazers

client.add_post_star(post_number)
#=> POST /v1/teams/foobar/posts/1/star

client.delete_post_star(post_number)
#=> DELETE /v1/teams/foobar/posts/1/star

client.comment_stargazers(comment_id)
#=> GET /v1/teams/foobar/comments/123/stargazers

client.add_comment_star(comment_id)
#=> POST /v1/teams/foobar/comments/123/star

client.delete_comment_star(comment_id)
#=> DELETE /v1/teams/foobar/comments/123/star


# Watch API
client.watchers(post_number)
#=> GET /v1/teams/foobar/posts/1/watchers

client.add_watch(post_number)
#=> POST /v1/teams/foobar/posts/1/watch

client.delete_watch(post_number)
#=> DELETE /v1/teams/foobar/posts/1/watch

# Categories API
client.categories
#=> GET /v1/teams/foobar/categories

client.batch_move_category(from: '/esa/', to: '/tori/piyo/')
#=> POST /v1/teams/foobar/categories/batch_move

# Tags API
client.tags
#=> GET /v1/teams/foobar/tags

# Invitation API
client.invitation
#=> GET /v1/teams/foobar/invitation

client.regenerate_invitation
#=> POST /v1/teams/foobar/invitation_regenerator

client.pending_invitations
#=> GET /v1/teams/foobar/invitations

client.send_invitation(emails)
#=> POST /v1/teams/foobar/invitations

client.cancel_invitation(invitation_code)
#=> DELETE /v1/teams/foobar/invitations/baz

# Emoji API
client.emojis
#=> GET /v1/teams/foobar/emojis

client.create_emoji(code: 'team_emoji', image: '/path/to/image')
#=> POST /v1/teams/foobar/emojis

client.create_emoji(code: 'alias_code', origin_code: 'team_emoji')
#=> POST /v1/teams/foobar/emojis

client.delete_emoji('team_emoji')
#=> DELETE /v1/teams/foobar/emojis/team_emoji

# Upload Attachment(beta)
client.upload_attachment('/Users/foo/Desktop/foo.png')                 # Path
client.upload_attachment(File.open('/Users/foo/Desktop/foo.png'))      # File
client.upload_attachment('http://example.com/foo.png')                 # Remote URL
client.upload_attachment(['http://example.com/foo.png', cookie_str])   # Remote URL + Cookie
client.upload_attachment(['http://example.com/foo.png', headers_hash]) # Remote URL + Headers

# Signed url for secure upload(beta)
client.signed_url('uploads/p/attachments/1/2016/08/16/1/foobar.png')
#=> GET /v1/teams/foobar/signed_url/uploads/p/attachments/1/2016/08/16/1/foobar.png
```


see also: [dev/api/v1 - docs.esa.io](https://docs.esa.io/posts/102)

## Contributing

1. Fork it ( https://github.com/esaio/esa-ruby/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
