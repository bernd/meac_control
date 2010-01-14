require File.expand_path(File.join(File.dirname(__FILE__), '..', '..', '..', 'spec_helper'))
require 'meac_control/xml/set_request'

class Dev; end
class Cmd; end

describe MEACControl::XML::SetRequest do
  it "creates a get request with one device and a list of commands" do
    req = MEACControl::XML::SetRequest.new(:one, [:one, :two, :three])
    req.should have(1).devices
    req.should have(3).commands
  end

  it "creates a get request with a list of devices and commands" do
    req = MEACControl::XML::SetRequest.new([:one, :two], [:one, :two, :three])
    req.should have(2).devices
    req.should have(3).commands
  end

  it "creates a get request with one device and one command" do
    req = MEACControl::XML::SetRequest.new(:two, :one)
    req.should have(1).devices
    req.should have(1).commands
  end

  it "fails to create a valid get request with an empty device list" do
    lambda {
      MEACControl::XML::SetRequest.new([], [:one, :two, :three])
    }.should raise_error(MEACControl::XML::Request::EmptyDeviceList)
  end

  it "fails to create a valid get request with a nil device" do
    lambda {
      MEACControl::XML::SetRequest.new(nil, [:one, :two, :three])
    }.should raise_error(MEACControl::XML::Request::EmptyDeviceList)
  end

  it "fails to create a valid get request with a nil command" do
    lambda {
      MEACControl::XML::SetRequest.new([:one, :two, :three], nil)
    }.should raise_error(MEACControl::XML::Request::EmptyCommandList)
  end

  # Example XML output:
  #   <?xml version="1.0" encoding="UTF-8"?>
  #   <Packet>
  #     <Command>setRequest</Command>
  #     <DatabaseManager>
  #       <Mnet Group="23" Drive="ON"/>
  #     </DatabaseManager>
  #   </Packet>
  describe "#to_xml" do
    before(:each) do
      device = mock(Dev, :id => 23)
      commands = [
        mock(Cmd, :to_get_string => 'Command="ON"', :to_get_hash => {:Command1 => 'ON'}),
        mock(Cmd, :to_get_string => 'Command="ON"', :to_get_hash => {:Command2 => 'ON'}),
        mock(Cmd, :to_get_string => 'Command="ON"', :to_get_hash => {:Command3  => 'ON'})
      ]
      @req = MEACControl::XML::SetRequest.new(device, commands)
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
      it "has a text of 'setRequest'" do
        @xml.root.at('/Packet/Command').text.should == "setRequest"
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

      it "has a 'Command1' attribute with value 'ON'" do
        @mnet.key?('Command1').should be_true
        @mnet.attribute('Command1').value.should == "ON"
      end

      it "has a 'Command2' attribute with value 'ON'" do
        @mnet.key?('Command2').should be_true
        @mnet.attribute('Command2').value.should == "ON"
      end

      it "has a 'Command3' attribute with value 'ON'" do
        @mnet.key?('Command3').should be_true
        @mnet.attribute('Command3').value.should == "ON"
      end

      it "has a parent node named 'DatabaseManager'" do
        @xml.root.at('/Packet/DatabaseManager/Mnet').parent.name.should == "DatabaseManager"
      end
    end
  end
end
