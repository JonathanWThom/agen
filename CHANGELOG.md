## [Released]

## [0.3] - 2021-06-17
- Adds support for bash shell.
- Adds ability to pass custom rcfile and histfile options.

## [0.2.1] - 2021-05-01
- Adds ability to modify aliases before writing them in interactive mode.

## [0.2.0] - 2021-04-30
- Adds interactive mode, allowing aliases to be accepted or rejected. On by
default.

## [0.1.7] - 2021-04-26
- Fix: Ensures the same aliases is not built for multiple commands in the same run.

## [0.1.6] - 2021-04-25
- Adds ability to specify number of aliases to generate.

## [0.1.5] - 2021-04-24

- Initial release that anyone should reasonably use.
    - Support for .zshrc/.zsh_history.
    - Automatically writes top 5 aliases for commands 6 characters or longer.
    - Avoids most alias naming conflicts with commands that already exist (e.g. `ls`).
    - Avoids duplicating aliases that have already been written.
