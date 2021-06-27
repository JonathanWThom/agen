# frozen_string_literal: true

module Agen
  class Runner
    CONFIG_FILE = "#{Dir.home}/.agen"
    DEFAULT_HISTFILE = ZshOptions::HISTFILE
    DEFAULT_RCFILE = ZshOptions::RCFILE
    DEFAULT_NUMBER = 5

    attr_reader :histfile, :rcfile

    def initialize(
      histfile: DEFAULT_HISTFILE,
      rcfile: DEFAULT_RCFILE,
      number: DEFAULT_NUMBER,
      auto: false,
      config_file: CONFIG_FILE
    )
      @histfile = histfile
      @rcfile = rcfile
      @number = number
      @auto = auto
      @config_file = config_file
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

    attr_reader :auto, :builder, :config_file

    def write_auto(file, full_alias)
      puts full_alias
      file.puts(full_alias)
    end

    def write_interactive(file, aliaz)
      puts "Proposed alias: #{aliaz[:full_alias]}"
      print "Accept? [n to reject, m to modify alias, i to ignore forever, any other key to accept]: "
      response = gets.chomp
      case response
      when "n"
        puts "Alias skipped"
      when "m"
        modify_alias(file, aliaz)
      when "i"
        ignore_alias(aliaz)
      else
        file.puts(aliaz[:full_alias])
        puts "Alias written"
      end

      puts
    end

    def ignore_alias(aliaz)
      command = aliaz[:command]
      File.open(config_file, "a") { |f| f.puts(command) }
      puts "Ignoring command '#{command}' forever"
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
