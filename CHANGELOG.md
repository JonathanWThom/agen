## [Released]

## [0.2.0] - 2021-04-30
- Fix: Ensures the same aliases is not built for multiple commands in the same run.

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
