# Cetacean

Operate HAL-based Hypermedia APIs in an object-oriented way.


## Usage

Something like this:

```ruby
api = Cetacean.new('https://api.example.com/')

users = api.links.users.get
user = users.embedded.first

important_blog_post = user.links.post.expand(id: 2).get
```


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
