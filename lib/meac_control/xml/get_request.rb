require 'nokogiri'

module MEACControl
  module XML
    class GetRequest
      attr_reader :devices, :commands

      def initialize(options = {})
        @devices = []
        @commands = []

        if options[:devices]
          @devices << options[:devices]
          @devices.flatten!
        end
        if options[:commands]
          @commands << options[:commands]
          @commands.flatten!
        end
      end

      def to_xml
        ::Nokogiri::XML::Builder.new(:encoding => 'UTF-8') do
          Packet do
            Command "getRequest"
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
