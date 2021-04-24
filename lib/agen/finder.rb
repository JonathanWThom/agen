# frozen_string_literal: true

module Agen
  class Finder
    def initialize(histfile)
      @histfile = histfile
    end

    def commands
      File.readlines(@histfile).map do |line|
        line.split(";").last.delete("\n")
      end
    end
  end
end
