# frozen_string_literal: true

module Agen
  class Runner
    DEFAULT_HISTFILE = "#{Dir.home}/.zsh_history"
    DEFAULT_RCFILE = "#{Dir.home}/.zshrc"
    DEFAULT_NUMBER = 5

    attr_reader :histfile, :rcfile

    def initialize(
      histfile: DEFAULT_HISTFILE,
      rcfile: DEFAULT_RCFILE,
      number: DEFAULT_NUMBER,
      auto: false
    )
      @histfile = histfile
      @rcfile = rcfile
      @number = number
      @auto = auto
    end

    def run
      commands = Finder.new(histfile).commands(limit: @number)
      aliases = Builder.new(commands, rcfile).aliases

      File.open(rcfile, "a") do |file|
        puts "Writing new aliases to #{rcfile}:"
        aliases.each do |al|
          if auto
            write_auto(file, al)
          else
            write_interactive(file, al)
          end
        end
      end
    end

    private

    attr_reader :auto

    def write_auto(file, aliaz)
      puts aliaz
      file.puts(aliaz)
    end

    def write_interactive(file, aliaz)
      puts "Proposed alias: #{aliaz}"
      print "Accept? [n to reject, any other key to accept]: "
      response = gets.chomp
      if response != "n"
        file.puts(aliaz)
        puts "Alias written"
      else
        puts "Alias skipped"
      end

      puts
    end
  end
end
