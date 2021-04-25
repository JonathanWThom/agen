# frozen_string_literal: true

module Agen
  class Runner
    DEFAULT_HISTFILE = "#{Dir.home}/.zsh_history"
    DEFAULT_RCFILE = "#{Dir.home}/.zshrc"

    attr_reader :histfile, :rcfile

    def initialize(histfile: DEFAULT_HISTFILE, rcfile: DEFAULT_RCFILE)
      @histfile = histfile
      @rcfile = rcfile
    end

    def run
      commands = Finder.new(histfile).commands
      aliases = Builder.new(commands, rcfile).aliases

      File.open(rcfile, "a") do |file|
        puts "Writing new aliases to #{rcfile}:"
        aliases.each do |al|
          puts al
          file.puts(al)
        end
      end
    end
  end
end
