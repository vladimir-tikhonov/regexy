module Regexy
  module Web
    PORT = /:([0-9]{1,4}|[1-5][0-9]{4}|6[0-4][0-9]{3}|65[0-4][0-9]{2}|655[0-2][0-9]|6553[0-5])$/i.freeze

    class IPv4 < ::Regexy::RegexpWithMode
      IPV4_NORMAL = /^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/i.freeze
      IPV4_WITH_PORT = ::Regexp.new(IPV4_NORMAL.source.chomp('$') + PORT.source).freeze

      protected

      def regexp_for(mode)
        case mode
        when :normal    then IPV4_NORMAL
        when :with_port then IPV4_WITH_PORT
        else nil
        end
      end
    end

    class IPv6 < ::Regexy::RegexpWithMode
      IPV6_NORMAL = /^(?:(?:(?:[A-F0-9]{1,4}:){6}|(?=(?:[A-F0-9]{0,4}:){0,6}(?:[0-9]{1,3}\.){3}
                     [0-9]{1,3}(?![:.\w]))(([0-9A-F]{1,4}:){0,5}|:)((:[0-9A-F]{1,4}){1,5}:|:)
                     |::(?:[A-F0-9]{1,4}:){5})(?:(?:25[0-5]|2[0-4][0-9]|1[0-9][0-9]|
                     [1-9]?[0-9])\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)|
                     (?:[A-F0-9]{1,4}:){7}[A-F0-9]{1,4}|(?=(?:[A-F0-9]{0,4}:){0,7}
                     [A-F0-9]{0,4}(?![:.\w]))(([0-9A-F]{1,4}:){1,7}|:)((:[0-9A-F]{1,4}){1,7}
                     |:)|(?:[A-F0-9]{1,4}:){7}:|:(:[A-F0-9]{1,4}){7})(?![:.\w])$
                    /ix.freeze

      IPV6_WITH_PORT = ::Regexp.new('[' + IPV6_NORMAL.source.chomp('$') + ']' + PORT.source).freeze

      protected

      def regexp_for(mode)
        case mode
          when :normal    then IPV6_NORMAL
          when :with_port then IPV6_WITH_PORT
          else nil
        end
      end
    end
  end
end
