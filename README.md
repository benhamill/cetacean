> Everything the system does *for* you, the system also does *to* you.
> <br>—Don Leaver

# Cetacean [![Build Status](https://travis-ci.org/benhamill/cetacean.png)](https://travis-ci.org/benhamill/cetacean) [![Code Climate](https://codeclimate.com/github/benhamill/cetacean.png)](https://codeclimate.com/github/benhamill/cetacean)

The [HAL](http://stateless.co/hal_specification.html) client that does almost
nothing for/to you.

Cetacean is tightly coupled to [Faraday](http://rubygems.org/gems/faraday), but
doesn't actually call it. You set up your own Faraday client and use it to make
requests. You feed Cetacean `Faraday::Request` objects and it helps you figure
out if they're HAL documents and pull useful data out of them if they are.


## Usage

Something like this:

```ruby
api = Faraday.new('https://api.example.com/') do |faraday|
  faraday.headers['Accept'] = 'application/hal+json'
end

root = Cetacean.new(api.get)
users = Cetacean.new(api.get(root.get_uri(:users).to_s))
user = users.embedded(:users).first

important_blog_post = Cetacean.new(api.get(user.get_uri(:post).expand(id: 2)))

interesting_blog_posts = Cetacean.new(api.get(root.get_uri(:search_posts).expand(q: 'interesting')))
```

Check out the specs for more detailed uses.


## Contributing

Help is gladly welcomed. If you have a feature you'd like to add, it's much more
likely to get in (or get in faster) the closer you stick to these steps:

1. Open an Issue to talk about it. We can discuss whether it's the right
  direction or maybe help track down a bug, etc.
1. Fork the project, and make a branch to work on your feature/fix. Master is
  where you'll want to start from.
1. Turn the Issue into a Pull Request. There are several ways to do this, but
  [hub](https://github.com/defunkt/hub) is probably the easiest.
1. Make sure your Pull Request includes tests.
1. Bonus points if your Pull Request updates `CHANGES.md` to include a summary
   of your changes and your name like the other entries. If the last entry is
   the last release, add a new `## Unreleased` heading at the top.

If you don't know how to fix something, even just a Pull Request that includes a
failing test can be helpful. If in doubt, make an Issue to discuss.
