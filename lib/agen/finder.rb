# frozen_string_literal: true

module Agen
  class Finder
    def initialize(histfile)
      @histfile = histfile
    end

    def commands
      File.readlines(@histfile).reverse.each_with_object(Hash.new(0)) do |line, commands|
        commands[line.split(";").last.delete("\n")] += 1
      end.sort_by { |k, v| -v }.to_h.keys.first(5)
    end
  end
end
