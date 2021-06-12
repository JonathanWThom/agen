# frozen_string_literal: true

module Agen
  class BashOptions < BaseOptions
    HISTFILE = "#{Dir.home}/.bash_history"
    RCFILE = "#{Dir.home}/.bashrc"
  end
end
