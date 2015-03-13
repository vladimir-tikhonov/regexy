# encoding: UTF-8

module Regexy
  module Web
    class Hashtag < ::Regexy::Regexp
      HASHTAG = /^#(?=.{2,140}$)([0-9_\p{L}]*[_\p{L}][0-9_\p{L}]*)$/u.freeze

      def initialize(*args)
        super(HASHTAG, *args)
      end
    end
  end
end