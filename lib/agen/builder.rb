# frozen_string_literal: true

module Agen
  class Builder
    def initialize(commands)
      @commands = commands
    end

    def aliases
      @commands.map do |cmd|
        aliaz = cmd.scan(/\b\w/).join

        # Is is possibly we could overwrite a command here still? Sure.
        # I will live with it for now.
        if command_already_exists?(aliaz)
          # We could improve to look more like the original command, but again, works for now.
          aliaz += aliaz[-1]
        end

        "alias #{aliaz}=\"#{cmd}\""
      end
    end

    # Shoutout to Stack Overflow: https://stackoverflow.com/a/5471032
    def command_already_exists?(cmd)
      exts = ENV["PATHEXT"] ? ENV["PATHEXT"].split(";") : [""]
      ENV["PATH"].split(File::PATH_SEPARATOR).each do |path|
        exts.each do |ext|
          exe = File.join(path, "#{cmd}#{ext}")
          return true if File.executable?(exe) && !File.directory?(exe)
        end
      end

      false
    end
  end
end
