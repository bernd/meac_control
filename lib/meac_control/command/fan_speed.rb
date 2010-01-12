require 'meac_control/command/generic'

module MEACControl
  module Command
    class FanSpeed
      include MEACControl::Command::Generic

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
