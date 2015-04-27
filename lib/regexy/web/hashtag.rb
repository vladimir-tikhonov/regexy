# encoding: UTF-8

module Regexy
  module Web
    class Hashtag < ::Regexy::Regexp
      HASHTAG = /\A(#(?=.{2,140}\z)([0-9_\p{L}]*[_\p{L}][0-9_\p{L}]*))\z/ui.freeze

      def initialize(*args)
        super(HASHTAG, *args)
      end
    end
  end
end
