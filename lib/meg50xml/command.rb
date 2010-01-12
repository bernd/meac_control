module Meg50XML
  module Command
    class InvalidValue < Exception
    end

    module Generic
      attr_reader :command, :value

      def to_set_string
        raise Meg50XML::Command::InvalidValue if (value.nil? or value.empty?)
        "#{command}=\"#{value}\""
      end

      def to_get_string
        "#{command}=\"*\""
      end

      def command_set?
        (value.nil? or value.empty?) ? false : true
      end
    end

    class Drive
      include Meg50XML::Command::Generic

      def initialize
        @command = 'Drive'
      end

      def on
        @value = 'ON'
      end

      def off
        @value = 'OFF'
      end
    end

    class FanSpeed
      include Meg50XML::Command::Generic

      def initialize
        @command = 'FanSpeed'
      end

      def low
        @value = 'low'
      end

      def mid1
        @value = 'mid1'
      end

      def mid2
        @value = 'mid2'
      end

      def high
        @value = 'high'
      end

      def auto
        @value = 'auto'
      end
    end
  end
end
