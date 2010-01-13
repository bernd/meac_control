require File.expand_path(File.join(File.dirname(__FILE__), '..', '..', '..', 'spec_helper'))
require 'meac_control/xml/get_request'

class Dev; end
class Cmd; end

describe MEACControl::XML::GetRequest do
  it "creates a get request with a list of devices" do
    req = MEACControl::XML::GetRequest.new(:devices => [:one, :two])
    req.should have(2).devices
  end

  it "creates a get request with a list of commands" do
    req = MEACControl::XML::GetRequest.new(:commands => [:one, :two, :three])
    req.should have(3).commands
  end

  # Example XML output:
  #   <?xml version="1.0" encoding="UTF-8"?>
  #   <Packet>
  #     <Command>getRequest</Command>
  #     <DatabaseManager>
  #       <Mnet Group="23" Drive="*"/>
  #     </DatabaseManager>
  #   </Packet>
  describe "#to_xml" do
    before(:each) do
      device = mock(Dev, :id => 23)
      commands = [
        mock(Cmd, :to_get_string => 'Command="*"', :to_get_hash => {:Command1 => '*'}),
        mock(Cmd, :to_get_string => 'Command="*"', :to_get_hash => {:Command2 => '*'}),
        mock(Cmd, :to_get_string => 'Command="*"', :to_get_hash => {:Command3  => '*'})
      ]
      @req = MEACControl::XML::GetRequest.new(:devices => device, :commands => commands)
      @xml = Nokogiri::XML(@req.to_xml)
    end

    it "has one root node named 'Packet'" do
      @xml.root.name.should == 'Packet'
    end

    describe "<Packet>" do
      it "has one child node named 'Command'" do
        @xml.root.search('/Packet/Command').size.should == 1
      end

      it "has one child node named 'DatabaseManager'" do
        @xml.root.search('/Packet/DatabaseManager').size.should == 1
      end
    end

    describe "<Command>" do
      it "has a text of 'getRequest'" do
        @xml.root.at('/Packet/Command').text.should == "getRequest"
      end

      it "has a parent node named 'Packet'" do
        @xml.root.at('/Packet/Command').parent.name.should == "Packet"
      end
    end

    describe "<DatabaseManager>" do
      it "has one chile node named 'Mnet'" do
        @xml.root.search('/Packet/DatabaseManager/Mnet').size.should == 1
      end

      it "has a parent node named 'Packet'" do
        @xml.root.at('/Packet/DatabaseManager').parent.name.should == "Packet"
      end
    end

    describe "<Mnet>" do
      before(:each) do
        @mnet = @xml.root.at('/Packet/DatabaseManager/Mnet')
      end

      it "has a 'Group' attribute with value '23'" do
        @mnet.key?('Group').should be_true
        @mnet.attribute('Group').value.should == "23"
      end

      it "has a 'Command1' attribute with value '*'" do
        @mnet.key?('Command1').should be_true
        @mnet.attribute('Command1').value.should == "*"
      end

      it "has a 'Command2' attribute with value '*'" do
        @mnet.key?('Command2').should be_true
        @mnet.attribute('Command2').value.should == "*"
      end

      it "has a 'Command3' attribute with value '*'" do
        @mnet.key?('Command3').should be_true
        @mnet.attribute('Command3').value.should == "*"
      end

      it "has a parent node named 'DatabaseManager'" do
        @xml.root.at('/Packet/DatabaseManager/Mnet').parent.name.should == "DatabaseManager"
      end
    end
  end
end
