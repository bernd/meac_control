require 'meg50xml/command/generic'

module Meg50XML
  module Command
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
  end
end
