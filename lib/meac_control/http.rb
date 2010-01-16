require 'meac_control/xml/get_request'
require 'meac_control/xml/set_request'
require 'meac_control/xml/response'
require 'httpclient'

module MEACControl
  class HTTP
    URI_TEMPLATE = 'http://%s/servlet/MIMEReceiveServlet'
    DEFAULT_HEADER = {'Accept' => 'text/xml', 'Content-Type' => 'text/xml'}

    class << self
      def get(host, devices, commands)
        action(host, MEACControl::XML::GetRequest.new(devices, commands))
      end

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
