require 'meac_control/xml/get_request'
require 'meac_control/xml/set_request'
require 'meac_control/xml/response'
require 'httpclient'

module MEACControl
  class HTTP
    URI_TEMPLATE = 'http://%s/servlet/MIMEReceiveServlet'
    DEFAULT_HEADER = {'Accept' => 'text/xml', 'Content-Type' => 'text/xml'}

    class << self
      # Executes a get request and returns a MEACControl::XML::Response object.
      #
      # Example:
      #   device = MEACControl::Device.new(23)
      #   command = MEACControl::Command::Drive.request
      #   resp = MEACControl::HTTP.get('127.0.0.1', device, command)
      #   resp.inspect # => "#<MEACControl::XML::Response:0x8bea3ef0 ...>"
      def get(host, devices, commands)
        action(host, MEACControl::XML::GetRequest.new(devices, commands))
      end

      # Executes a set request and returns a MEACControl::XML::Response object.
      #
      # Example:
      #   device = MEACControl::Device.new(23)
      #   command = MEACControl::Command::Drive.new
      #   command.off
      #   resp = MEACControl::HTTP.set('127.0.0.1', device, command)
      #   resp.inspect # => "#<MEACControl::XML::Response:0x8bea3ef0 ...>"
      def set(host, devices, commands)
        action(host, MEACControl::XML::SetRequest.new(devices, commands))
      end

      private
        def action(host, request)
          resp = HTTPClient.post(sprintf(URI_TEMPLATE, host), request.to_xml, DEFAULT_HEADER)
          MEACControl::XML::Response.new(resp.content, request)
        end
    end
  end
end
