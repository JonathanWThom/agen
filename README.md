# Agen

[![Build](https://github.com/JonathanWThom/agen/actions/workflows/main.yml/badge.svg)](https://github.com/JonathanWThom/agen/actions/workflows/main.yml)

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

* CLI will let you see proposed aliases and accept/decline them interactively. Maybe auto should be the default?
   OR, in "auto mode", commands will be added automatically (as in 1).
*  CLI should have helpful output for `-h/--help`.
* CLI will let you specify number of aliases you want to create.
* CLI will support any (or most common) shells, and will find history and rc
   file dynamically.
* CLI will let you specific which history file to read form, and which file to output aliases to.
* CLI will let you interactively modify proposed aliases.
* CLI will let you "ignore" commands you don't want to alias, forever.
* CLI will let you specify "meta" vs "full" commands.
  - Full command would be `git checkout branch-name`, meta command would be
      `git checkout`.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
