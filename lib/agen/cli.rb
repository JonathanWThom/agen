# frozen_string_literal: true

module Agen
  class CLI
    def initialize(args = [])
      @args = args
    end

    def run
      # TODO: Parse args/options
      Runner.new.run
    end
  end
end
