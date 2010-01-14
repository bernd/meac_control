require File.expand_path(File.join(File.dirname(__FILE__), '..', '..', '..', 'spec_helper'))
require 'meac_control/xml/set_request'

class Dev; end
class Cmd; end

describe MEACControl::XML::SetRequest do
  it "inherits from the MEACControl::XML::AbstractRequest class" do
    req = MEACControl::XML::SetRequest.new(:one, [:one, :two, :three])
    req.should be_kind_of(MEACControl::XML::AbstractRequest)
  end

  describe "#to_xml" do
    it "returns a xml string with 'setRequest' in the <Command> element" do
      device = mock(Dev, :id => 23)
      commands = [
        mock(Cmd, :hash_for => {:Command1 => 'ON'}),
        mock(Cmd, :hash_for => {:Command2 => 'ON'}),
        mock(Cmd, :hash_for => {:Command3  => 'ON'})
      ]
      req = MEACControl::XML::SetRequest.new(device, commands)
      xml = Nokogiri::XML(req.to_xml)
      xml.root.at('/Packet/Command').text.should == "setRequest"
    end
  end
end
