# Agen

Generate shell aliases based on your most commonly entered commands.

## Installation & Usage

Install with `gem install agen` and then run `agen` to build your aliases.

Right now, this will only work with `zsh`, but support for other shells is on
the very lengthy todo list.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/JonathanWThom/agen.

## Roadmap

1. CLI will read 5 most common full commands from .zsh_history file, and create
   an alias for them in the .zshrc file.
   [] It should not create aliases out of old aliases.
   [x] It should handle a very short or shell history without many different
      commands.
   [x] It should not create the same alias for two different commands in the same
       session.
   [x] It should not create aliases for very short commands.
1. CLI will let you see proposed aliases and accept/decline them interactively.
   OR, in "auto mode", commands will be added automatically (as in 1).
1. CLI should have helpful output for `-h/--help`.
1. CLI will let you specify number of aliases you want to create.
1. CLI will support any (or most common) shells, and will find history and rc
   file dynamically.
1. CLI will let you specific which history file to read form, and which file to output aliases to.
1. CLI will let you interactively modify proposed aliases.
1. CLI will let you "ignore" commands you don't want to alias, forever.
1. CLI will let you specify "meta" vs "full" commands.
  - Full command would be `git checkout branch-name`, meta command would be
      `git checkout`.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
