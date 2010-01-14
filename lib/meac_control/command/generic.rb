module MEACControl
  module Command
    class InvalidValue < Exception
    end

    class Generic
      attr_reader :command, :value

      def self.request
        new.freeze
      end

      def to_set_string
        raise MEACControl::Command::InvalidValue if (value.nil? or value.empty?)
        "#{command}=\"#{value}\""
      end

      def to_set_hash
        raise MEACControl::Command::InvalidValue if (value.nil? or value.empty?)
        {command.to_sym => value}
      end

      def to_get_string
        "#{command}=\"*\""
      end

      def to_get_hash
        {command.to_sym => '*'}
      end

      def command_set?
        (value.nil? or value.empty?) ? false : true
      end
    end
  end
end
