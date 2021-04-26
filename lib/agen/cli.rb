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
      end.parse!

      Runner.new(**options).run
    end
  end
end
