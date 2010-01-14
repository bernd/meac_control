require 'nokogiri'
require 'meac_control/xml/exceptions'

module MEACControl
  module XML
    class SetRequest
      attr_reader :devices, :commands

      def initialize(devices, commands)
        @devices = [devices].compact.flatten
        @commands = [commands].compact.flatten

        raise MEACControl::XML::Request::EmptyDeviceList if @devices.empty?
        raise MEACControl::XML::Request::EmptyCommandList if @commands.empty?
      end

      def to_xml
        ::Nokogiri::XML::Builder.new(:encoding => 'UTF-8') do
          Packet do
            Command "setRequest"
            DatabaseManager do
              devices.each do |dev|
                attributes = {:Group => dev.id}
                commands.each do |cmd|
                  attributes.merge!(cmd.to_get_hash)
                end
                Mnet(attributes)
              end
            end
          end
        end.to_xml
      end
    end
  end
end
