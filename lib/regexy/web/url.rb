# encoding: UTF-8

module Regexy
  module Web
    class Url < ::Regexy::Regexp
      URL = /^([a-z][a-z\d+\-.]*:(\/\/([\p{L}\d\-._~%!$&'()*+,;=]+@)?([\p{L}\d\-._~%]+|
             \[[\p{L}\d:.]+\]|\[v[a-f0-9][\p{L}\d\-._~%!$&'()*+,;=:]+\])(:[0-9]+)?
             (\/[\p{L}\d\-._~%!$&'()*+,;=:@]+)*\/?|(\/?[\p{L}\d\-._~%!$&'()*+,;=:@]+
             (\/[\p{L}\d\-._~%!$&'()*+,;=:@]+)*\/?)?)|([\p{L}\d\-._~%!$&'()*+,;=@]+
             (\/[\p{L}\d\-._~%!$&'()*+,;=:@]+)*\/?|(\/[\p{L}\d\-._~%!$&'()*+,;=:@]+)
             +\/?))
             (\?[\p{L}\d\-._~%!$&'()*+,;=:@\/?]*)?(\#[\p{L}\d\-._~%!$&'()*+,;=:@\/?]*)?$
            /ix.freeze

      def initialize(*args)
        super(URL, *args)
      end
    end
  end
end