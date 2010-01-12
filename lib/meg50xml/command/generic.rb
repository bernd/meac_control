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
  end
end
