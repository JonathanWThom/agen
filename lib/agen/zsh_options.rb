# frozen_string_literal: true

module Agen
  class ZshOptions < BaseOptions
    HISTFILE = "#{Dir.home}/.zsh_history"
    RCFILE = "#{Dir.home}/.zshrc"
  end
end
