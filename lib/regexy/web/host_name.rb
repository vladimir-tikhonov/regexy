# encoding: UTF-8

module Regexy
  module Web
    class HostName < ::Regexy::Regexp
      HOST_NAME = /\A([\p{L}\d_]([\p{L}\d\-_]{0,61}[\p{L}\d])?\.)+[\p{L}]{2,6}\z/i.freeze

      def initialize(*args)
        super(HOST_NAME, *args)
      end
    end
  end
end