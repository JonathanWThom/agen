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
      @builder = Builder.new(commands, rcfile)
      aliases = builder.aliases

      # TODO: This could be its own class too
      File.open(rcfile, "a") do |file|
        puts "Writing new aliases to #{rcfile}:\n\n"
        aliases.each do |al|
          if auto
            write_auto(file, al[:full_alias])
          else
            write_interactive(file, al)
          end
        end
      end
    end

    private

    attr_reader :auto, :builder

    def write_auto(file, full_alias)
      puts full_alias
      file.puts(full_alias)
    end

    def write_interactive(file, aliaz)
      puts "Proposed alias: #{aliaz[:full_alias]}"
      print "Accept? [n to reject, m to modify alias, any other key to accept]: "
      response = gets.chomp
      case response
      when "n"
        puts "Alias skipped"
      when "m"
        modify_alias(file, aliaz)
      else
        file.puts(aliaz[:full_alias])
        puts "Alias written"
      end

      puts
    end

    def modify_alias(file, aliaz)
      print "Enter new alias [replacing #{aliaz[:alias]}]: "
      replacement = gets.chomp
      if replacement == ""
        modify_alias(file, aliaz)
        return
      end

      file.puts(builder.construct_alias(replacement, aliaz[:command]))
      puts "Alias written"
    end
  end
end
