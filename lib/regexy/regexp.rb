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

    def | other
      other = ::Regexy::Regexp.new(other)
      new_regexp = "#{source}|#{other.source}"
      new_options = options | other.options
      ::Regexy::Regexp.new(new_regexp, new_options)
    end

    alias_method :or, :|

    def + other
      other = ::Regexy::Regexp.new(other)
      first_regex = source.length > 2 ? source.sub(/\\z\s*\z/, '') : source
      second_regex = other.source.length > 2 ? other.source.sub(/\A\\A/, '') : other.source
      new_regexp = first_regex + second_regex
      new_options = options | other.options
      ::Regexy::Regexp.new(new_regexp, new_options)
    end

    alias_method :and_then, :+

    def bound(method = :both)
      new_regexp = source
      method = method.to_sym
      if method == :left || method == :both
        new_regexp.prepend('\A')
      end
      if method == :right || method == :both
        new_regexp.concat('\z')
      end
      ::Regexy::Regexp.new(new_regexp, options)
    end

    def unbound(method = :both)
      new_regexp = source
      method = method.to_sym
      if method == :left || method == :both
        new_regexp.sub!(/\A\\A/, '')
      end
      if method == :right || method == :both
        new_regexp.sub!(/\\z\s*\z/, '')
      end
      ::Regexy::Regexp.new(new_regexp, options)
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