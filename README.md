# Agen

[![Build](https://github.com/JonathanWThom/agen/actions/workflows/main.yml/badge.svg)](https://github.com/JonathanWThom/agen/actions/workflows/main.yml)

Generate shell aliases based on your most commonly entered commands.

https://user-images.githubusercontent.com/22665228/116796045-5e5a8280-aa8e-11eb-8b4c-4408a252c143.mov


## Installation & Usage

Install with `gem install agen` and then run `agen` to build your aliases. Then
be sure to `source ~/.zshrc` before using the new aliases. Use `agen -h` to see
available options.

```
Usage: agen [options]
    -n, --number=NUMBER              Number of aliases to generate
    -a, --auto                       Aliases will be generated and applied automatically
    -r, --rcfile=RCFILE              Path to shell rc file
    -h, --histfile=HISTFILE          Path to shell history file
```

Right now, this will only work with `zsh` or `bash`, but you can specify unique shell config files using the `-r` and `-h` options (though there is no guarantee that your history file will be read properly). By default, agen reads from `.zsh_history` and
writes to `.zshrc`.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/JonathanWThom/agen.

## Roadmap

* CLI will let you "ignore" commands you don't want to alias, forever.
* CLI will raise user friendly errors if you specify shell configuration files that don't exist.
* CLI will let you specify "meta" vs "full" commands.
  - Full command would be `git checkout branch-name`, meta command would be `git checkout`.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
