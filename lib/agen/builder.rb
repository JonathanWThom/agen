# frozen_string_literal: true

module Agen
  class Builder
    def initialize(commands)
      @commands = commands
    end

    def aliases
      @commands.map do |cmd|
        aliaz = cmd.scan(/\b\w/).join
        "alias #{aliaz}=\"#{cmd}\""
      end
    end
  end
end
