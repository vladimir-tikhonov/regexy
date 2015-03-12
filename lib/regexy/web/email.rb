# encoding: UTF-8

module Regexy
  module Web
    class Email < ::Regexy::Regexp
      REGEXES = {
        relaxed: /\A\s*[^@\s]+@([^@\s]+\.)+[^@\s]+\s*\z/,
        normal:  /\A\s*([^@\s]{1,64})@((?:[-\p{L}\d]+\.)+\p{L}{2,})\s*\z/i,
        strict:  /\A\s*([-\p{L}\d+._]{1,64})@((?:[-\p{L}\d]+\.)+\p{L}{2,})\s*\z/i
      }.freeze

      def initialize(mode = :normal, *arg)
        regexp = REGEXES[mode.to_sym]
        fail ArgumentError, "Unknown mode #{mode.to_s}" unless regexp
        super(regexp, *arg)
      end
    end
  end
end