# encoding: UTF-8

module Regexy
  module Text
    class Emoji < Regexy::Regexp
      SMILE_REGEX = /([\u{1F600}-\u{1F6FF}])/i

      def initialize(*args)
        super(SMILE_REGEX, *args)
      end
    end
  end
end