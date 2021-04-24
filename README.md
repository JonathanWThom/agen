# Agen

Generate shell aliases based on commonly entered commands.

## Roadmap

1. CLI will read 5 most common full commands from .zsh_history file, and create
   an alias for them in the .zshrc file.
   - It should not create aliases out of old aliases.
   - It should handle a very short or shell history without many different
      commands.
   - It should output progress for very long/slow shell histories.
   - It should not create the same alias for two different commands in the same
       session.
   - It should not create an alias that is longer than the original command.
2. CLI will let you see proposed aliases and accept/decline them interactively.
   OR, in "auto mode", commands will be added automatically (as in 1).
3. CLI will let you specify number of aliases you want to create.
4. CLI will support any (or most common) shells, and will find history and rc
   file dynamically.
5. CLI will let you specific which history file to read form, and which file to output aliases to.
6. CLI will let you interactively modify proposed aliases.
7. CLI will let you "ignore" commands you don't want to alias, forever.
8. CLI will let you specify "meta" vs "full" commands.
  - Full command would be `git checkout branch-name`, meta command would be
      `git checkout`.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'agen'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install agen

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/agen.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
