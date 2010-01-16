require File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'spec_helper'))
require 'meac_control/http'

describe MEACControl::HTTP do
  describe "URI_TEMPLATE constant" do
    it "can be used to build the correct uri" do
      uri = sprintf(MEACControl::HTTP::URI_TEMPLATE, '10.0.0.1')
      uri.should == 'http://10.0.0.1/servlet/MIMEReceiveServlet'
    end
  end

  describe "DEFAULT_HEADER constant" do
    it "has 'Accept' set to 'text/xml'" do
      MEACControl::HTTP::DEFAULT_HEADER['Accept'].should == 'text/xml'
    end

    it "has 'Content-Type' set to 'text/xml'" do
      MEACControl::HTTP::DEFAULT_HEADER['Content-Type'].should == 'text/xml'
    end
  end

  before(:each) do
    @device = mock('device')
    @command = mock('command')
    @hostname = '127.0.0.1'
    @uri = sprintf(MEACControl::HTTP::URI_TEMPLATE, @hostname)
  end

  describe ".get" do
    before(:each) do
      @xml = mock('xml_request', :to_xml => fixture_read('get-request.xml'))

      HTTPClient.should_receive(:post).with(@uri, @xml.to_xml, MEACControl::HTTP::DEFAULT_HEADER).and_return do
        mock('http_response', :content => fixture_read('get-response-ok.xml'))
      end

      MEACControl::XML::GetRequest.should_receive(:new).with(@device, @command).and_return(@xml)
    end

    it "executes a get request" do
      MEACControl::HTTP.get(@hostname, @device, @command)
    end

    it "returns a response object" do
      MEACControl::HTTP.get(@hostname, @device, @command).should be_ok
    end

    it "returns a response object which includes the request object" do
      MEACControl::HTTP.get(@hostname, @device, @command).request.should == @xml
    end
  end

  describe ".set" do
    before(:each) do
      @xml = mock('xml_request', :to_xml => fixture_read('set-request.xml'))

      HTTPClient.should_receive(:post).with(@uri, @xml.to_xml, MEACControl::HTTP::DEFAULT_HEADER).and_return do
        mock('http_response', :content => fixture_read('get-response-ok.xml'))
      end

      MEACControl::XML::SetRequest.should_receive(:new).with(@device, @command).and_return(@xml)
    end

    it "executes a set request" do
      MEACControl::HTTP.set(@hostname, @device, @command)
    end

    it "returns a response object" do
      MEACControl::HTTP.set(@hostname, @device, @command).should be_ok
    end

    it "returns a response object which includes the request object" do
      MEACControl::HTTP.set(@hostname, @device, @command).request.should == @xml
    end
  end
end
