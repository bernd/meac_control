require 'meac_control/command/generic'

module MEACControl
  module Command
    class InletTemp < Generic
      def initialize
        @command = 'InletTemp'
      end
    end
  end
end
