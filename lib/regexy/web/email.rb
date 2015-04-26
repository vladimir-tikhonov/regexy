# encoding: UTF-8

module Regexy
  module Web
    class Email < ::Regexy::RegexpWithMode
      EMAIL_RELAXED = /\A\s*(([^@\s]+)@(([^@\s]+\.)+[^@\s]+))\s*\z/i.freeze
      EMAIL_NORMAL =  /\A\s*(([^@\s]{1,64})@((?:[-\p{L}\d]+\.)+\p{L}{2,}))\s*\z/i.freeze
      EMAIL_STRICT =  /\A\s*(([-\p{L}\d+._]{1,64})@((?:[-\p{L}\d]+\.)+\p{L}{2,}))\s*\z/i.freeze

      protected

      def regexp_for(mode)
        case mode
        when :relaxed then EMAIL_RELAXED
        when :normal  then EMAIL_NORMAL
        when :strict  then EMAIL_STRICT
        else nil
        end
      end
    end
  end
end
