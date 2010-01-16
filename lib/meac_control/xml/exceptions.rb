module MEACControl
  module XML
    class Response
      class InvalidXml < Exception
      end
    end

    module Request
      class EmptyDeviceList < Exception
      end

      class EmptyCommandList < Exception
      end
    end
  end
end
