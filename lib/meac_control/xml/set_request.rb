require 'meac_control/xml/abstract_request'

module MEACControl
  module XML
    class SetRequest < AbstractRequest
      def to_xml
        xml_template('setRequest')
      end
    end
  end
end
