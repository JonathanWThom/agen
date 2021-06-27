# frozen_string_literal: true

module Agen
  class Finder
    LIMIT = 5
    MIN_CHARS = 6

    def initialize(histfile, config_file = Runner::CONFIG_FILE)
      @histfile = histfile
      @config_file = config_file
    end

    def commands(limit: LIMIT, min_chars: MIN_CHARS)
      lines
        .each_with_object(Hash.new(0)) do |line, commands|
        cmd = line.split(";").last.delete("\n")
        commands[cmd] += 1 if cmd != ""
      rescue => e
        puts e
      end
        .sort_by { |k, v| -v }
        .to_h
        .keys
        .select { |cmd| cmd.length >= min_chars }
        .select { |cmd| !ignored?(cmd) }
        .first(limit)
    end

    private

    attr_reader :config_file

    def ignored?(cmd)
      File.readlines(config_file).detect do |line|
        line.delete("\n") == cmd
      end
    rescue Errno::ENOENT
      # User hasn't ignored anything yet, so doesn't have a config file
    end

    def lines
      File.readlines(@histfile).reverse
    end
  end
end
