require 'meac_control/xml/abstract_request'

module MEACControl
  module XML
    class SetRequest < AbstractRequest
      def to_xml
        xml_template('setRequest', :set)
      end
    end
  end
end
