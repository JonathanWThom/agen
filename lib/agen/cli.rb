# frozen_string_literal: true

require "optparse"

module Agen
  class CLI
    def initialize(args = [])
      @args = args
    end

    def run
      options = {}

      OptionParser.new do |opts|
        opts.banner = "Usage: agen [options]"

        opts.on("-nNUMBER", "--number=NUMBER", Integer, "Number of aliases to generate") do |n|
          options[:number] = n
        end

        opts.on("-a", "--auto", "Aliases will be generated and applied automatically") do |a|
          options[:auto] = a
        end

        opts.on("-rRCFILE", "--rcfile=RCFILE", String, "Path to shell rc file") do |r|
          options[:rcfile] = r
        end

        opts.on("-hHISTFILE", "--histfile=HISTFILE", String, "Path to shell history file") do |h|
          options[:histfile] = h
        end
      end.parse!

      options = Shell.new(options).add_options
      return unless options

      Runner.new(**options).run
    end
  end
end
