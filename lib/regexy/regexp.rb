require 'forwardable'

module Regexy
  class Regexp
    extend Forwardable

    attr_reader :internal_regexp
    def_delegators :internal_regexp, *::Regexp.public_instance_methods(false)

    def initialize(regexp, *arg)
      regexp = regexp.internal_regexp if regexp.is_a?(::Regexy::Regexp)
      @internal_regexp = ::Regexp.new(regexp, *arg)
    end
  end
end