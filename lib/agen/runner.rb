# frozen_string_literal: true

module Agen
  class Runner
    DEFAULT_HISTFILE = "$HOME/.zsh_history"
    DEFAULT_RCFILE = "$HOME/.zshrc"

    attr_reader :histfile, :rcfile

    def initialize(histfile: DEFAULT_HISTFILE, rcfile: DEFAULT_RCFILE)
      @histfile = histfile
      @rcfile = rcfile
    end
  end
end
