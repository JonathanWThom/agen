# frozen_string_literal: true

require_relative "agen/version"
require_relative "agen/builder"
require_relative "agen/finder"
require_relative "agen/runner"

module Agen
  class Error < StandardError; end
end
