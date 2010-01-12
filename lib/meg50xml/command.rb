module Meg50XML
  module Command
    module Generic
      def to_s
        "#{command}=\"#{value}\""
      end

      def command_set?
        (value.nil? or value.empty?) ? false : true
      end
    end

    class Drive
      include Meg50XML::Command::Generic

      attr_reader :command, :value

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
