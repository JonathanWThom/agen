# frozen_string_literal: true

module Agen
  class Finder
    def initialize(histfile)
      @histfile = histfile
    end

    def commands(limit = 5)
      File.readlines(@histfile).reverse.each_with_object(Hash.new(0)) do |line, commands|
        begin
          cmd = line.split(";").last.delete("\n")
          if cmd != ""
            commands[line.split(";").last.delete("\n")] += 1
          end
        rescue
        end
      end.sort_by { |k, v| -v }.to_h.keys.first(limit)
    end
  end
end
