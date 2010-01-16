module MEACControl
  module XML
    class InvalidResponse < Exception
    end

    module Request
      class EmptyDeviceList < Exception
      end

      class EmptyCommandList < Exception
      end
    end
  end
end
