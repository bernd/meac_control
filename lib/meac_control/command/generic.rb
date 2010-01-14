module MEACControl
  module Command
    class InvalidValue < Exception
    end

    class InvalidMode < Exception
    end

    class Generic
      attr_reader :command, :value

      def self.request
        new.freeze
      end

      def hash_for(mode)
        if mode == :set
          raise MEACControl::Command::InvalidValue if (value.nil? or value.empty?)
          {command.to_sym => value}
        elsif mode == :get
          {command.to_sym => '*'}
        else
          raise MEACControl::Command::InvalidMode
        end
      end

      def command_set?
        (value.nil? or value.empty?) ? false : true
      end
    end
  end
end
