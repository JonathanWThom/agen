# frozen_string_literal: true

module Agen
  class BaseOptions
    def initialize(options)
      @options = options
    end

    def set_histfile
      # handle not set here
      if !defined?(self.class::HISTFILE)
        puts "Please specify shell history file with -h option. See agen --help."
        return false
      end

      options.tap do |opts|
        opts[:histfile] = self.class::HISTFILE
      end
    end

    def set_rcfile
      if !defined?(self.class::RCFILE)
        puts "Please specify shell rc file with -r option. See agen --help."
        return false
      end

      options.tap do |opts|
        opts[:rcfile] = self.class::RCFILE
      end
    end

    private

    attr_reader :options
  end
end
