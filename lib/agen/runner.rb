# frozen_string_literal: true

module Agen
  class Runner
    DEFAULT_HISTFILE = "#{Dir.home}/.zsh_history"
    DEFAULT_RCFILE = "#{Dir.home}/.zshrc"
    DEFAULT_NUMBER = 5

    attr_reader :histfile, :rcfile

    def initialize(histfile: DEFAULT_HISTFILE, rcfile: DEFAULT_RCFILE, number: DEFAULT_NUMBER)
      @histfile = histfile
      @rcfile = rcfile
      @number = number
    end

    def run
      commands = Finder.new(histfile).commands(limit: @number)
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
