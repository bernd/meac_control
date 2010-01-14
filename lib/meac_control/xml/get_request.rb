require 'meac_control/xml/abstract_request'

module MEACControl
  module XML
    class GetRequest < AbstractRequest
      # returns a xml get request.
      #
      # example:
      #   req = MEACControl::XML::GetRequest.new(device, command)
      #   req.to_xml # => "<?xml version="1.0" encoding="UTF-8"?>..."
      def to_xml
        xml_template('getRequest', :get)
      end
    end
  end
end
