require 'meg50xml/command/generic'

module Meg50XML
  module Command
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
