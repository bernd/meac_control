require File.expand_path(File.join(File.dirname(__FILE__), '..', '..', '..', 'spec_helper'))
require 'meac_control/xml/get_request'

class Dev; end
class Cmd; end

describe MEACControl::XML::GetRequest do
  it "inherits from the MEACControl::XML::AbstractRequest class" do
    req = MEACControl::XML::GetRequest.new(:one, [:one, :two, :three])
    req.should be_kind_of(MEACControl::XML::AbstractRequest)
  end

  describe "#to_xml" do
    it "returns a xml string with 'getRequest' in the <Command> element" do
      device = mock(Dev, :id => 23)
      commands = [
        mock(Cmd, :to_get_hash => {:Command1 => 'ON'}),
        mock(Cmd, :to_get_hash => {:Command2 => 'ON'}),
        mock(Cmd, :to_get_hash => {:Command3  => 'ON'})
      ]
      req = MEACControl::XML::GetRequest.new(device, commands)
      xml = Nokogiri::XML(req.to_xml)
      xml.root.at('/Packet/Command').text.should == "getRequest"
    end
  end
end
