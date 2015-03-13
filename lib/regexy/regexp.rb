require 'forwardable'

module Regexy
  class Regexp
    extend Forwardable

    attr_reader :internal_regexp
    def_delegators :internal_regexp, *::Regexp.public_instance_methods(false)

    def initialize(regexp, *args)
      regexp = normalize_regexp(regexp, *args)
      @internal_regexp = ::Regexp.new(regexp, *args)
    end

    protected

    def normalize_regexp(regexp, *args)
      case regexp
      when ::Regexy::Regexp then regexp.internal_regexp
      when ::Regexp then args.any? ? regexp.source : regexp # allows to pass custom options to regexp
      else regexp
      end
    end
  end

  class RegexpWithMode < ::Regexy::Regexp
    def initialize(mode = default_mode, *args)
      regexp = regexp_for(mode.to_sym)
      fail ArgumentError, "Unknown mode #{mode.to_s}" unless regexp
      super(regexp, *args)
    end

    protected

    def regexp_for(mode)
      fail NotImplementedError, 'Child classes should override #regexp_for method'
    end

    def default_mode
      :normal
    end
  end
end