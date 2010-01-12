require File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'spec_helper'))
require 'meac_control/device'

describe MEACControl::Device do
  describe "#id" do
    it "returns the device id" do
      MEACControl::Device.new(34).id.should == 34
    end
  end

  describe "#name" do
    it "returns the device name" do
      device = MEACControl::Device.new(23)
      device.name = "fooac"
      device.name.should == "fooac"
    end
  end

  it "will set the name value with the initializer option :name" do
    device = MEACControl::Device.new(22, :name => "foobarac")
    device.name.should == "foobarac"
  end
end
