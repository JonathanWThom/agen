# frozen_string_literal: true

module Agen
  class Shell
    def initialize(options)
      @options = options
    end

    def add_options
      if !@options[:histfile]
        @options = opts_klass.set_histfile
      end

      if @options && !@options[:rcfile]
        @options = opts_klass.set_rcfile
      end

      @options
    end

    private

    def bash?
      @_bash ||= shell.match?(/bash/)
    end

    def opts_klass
      @_opts_klass ||= begin
        if bash?
          BashOptions
        elsif zsh?
          ZshOptions
        else
          BaseOptions
        end.new(@options)
      end
    end

    def shell
      @_shell ||= ENV["SHELL"]
    end

    def zsh?
      @_zsh ||= shell.match?(/zsh/)
    end
  end
end
