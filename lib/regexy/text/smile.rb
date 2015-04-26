module Regexy
  module Text
    class Smile < Regexy::Regexp
      SMILE_REGEX = /\A((?<![\\:;x])[:8bx;][-=]?[dx\)\(0op\*\#s\\\/](?![\)\(\*\/\\\#]))\z/i

      def initialize(*args)
        super(SMILE_REGEX, *args)
      end
    end
  end
end
