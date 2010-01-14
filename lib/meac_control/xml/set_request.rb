require 'meac_control/xml/abstract_request'

module MEACControl
  module XML
    class SetRequest < AbstractRequest
      # returns a xml set request.
      #
      # example:
      #   req = MEACControl::XML::SetRequest.new(device, command)
      #   req.to_xml # => "<?xml version="1.0" encoding="UTF-8"?>..."
      def to_xml
        xml_template('setRequest', :set)
      end
    end
  end
end
