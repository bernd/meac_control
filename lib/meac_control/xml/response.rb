require 'nokogiri'
require 'meac_control/xml/exceptions'

module MEACControl
  module XML
    class Response
      attr_reader :xml

      def initialize(xml)
        @xml = ::Nokogiri::XML(xml)
        raise(MEACControl::XML::InvalidResponse, @xml.to_s) if @xml.root.nil?
      end

      def ok?
        !errors?
      end

      def errors?
        !@xml.xpath('/Packet/DatabaseManager/ERROR').empty?
      end

      def errors
        @xml.xpath('/Packet/DatabaseManager/ERROR').map do |error|
          data = {}
          error.each do |key, value|
            data[key] = value
          end
          data
        end
      end

      def error_messages
        errors.map do |error|
          error['Message']
        end
      end
    end
  end
end
