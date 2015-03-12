module Regexy
  module Web
    class IPv4 < ::Regexy::Regexp
      REGEXES = {
        normal: /^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/,
        with_port: /^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?):
                    ([0-9]{1,4}|[1-5][0-9]{4}|6[0-4][0-9]{3}|65[0-4][0-9]{2}|655[0-2][0-9]|6553[0-5])$/x
      }.freeze

      def initialize(mode = :normal, *arg)
        regexp = REGEXES[mode.to_sym]
        fail ArgumentError, "Unknown mode #{mode.to_s}" unless regexp
        super(regexp, *arg)
      end
    end

    class IPv6 < ::Regexy::Regexp
      REGEXP = //.freeze

      def initialize(*arg)
        super(REGEXP, *arg)
      end
    end
  end
end