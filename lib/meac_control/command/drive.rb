require 'meac_control/command/generic'

module MEACControl
  module Command
    class Drive < Generic

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
  end
end
