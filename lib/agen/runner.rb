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

    def call
      commands = Finder.new(histfile).commands
      aliases = Builder.new(commands).aliases

      # alias writer
      File.open(rcfile, "a") do |file|
        aliases.each do |al|
          file.puts
          file << al
        end
      end
    end
  end
end
