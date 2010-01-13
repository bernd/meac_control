require File.expand_path(File.join(File.dirname(__FILE__), '..', '..', '..', 'spec_helper'))
require 'meac_control/command/generic'

class Cmd; end

describe MEACControl::Command::Generic do
  before(:each) do
    @obj = mock(Cmd, :command= => nil, :value= => nil, :value => "MyValue", :command => "MyCommand")
    @obj.send(:extend, MEACControl::Command::Generic)
  end

  describe "#to_set_string" do
    it "returns the string representation of command and value" do
      @obj.to_set_string.should == "#{@obj.command}=\"#{@obj.value}\""
    end

    it "will raise an exception if value is nil" do
      @obj.stub!(:value).and_return(nil)
      lambda { @obj.to_set_string }.should raise_error(MEACControl::Command::InvalidValue)
    end

    it "will raise an exception if value is an empty string" do
      @obj.stub!(:value).and_return('')
      lambda { @obj.to_set_string }.should raise_error(MEACControl::Command::InvalidValue)
    end
  end

  describe "#to_set_hash" do
    it "returns the command and value as a hash" do
      @obj.to_set_hash.should == {@obj.command.to_sym => @obj.value}
    end

    it "will raise an exception if value is nil" do
      @obj.stub!(:value).and_return(nil)
      lambda { @obj.to_set_hash }.should raise_error(MEACControl::Command::InvalidValue)
    end

    it "will raise an exception if value is an empty string" do
      @obj.stub!(:value).and_return('')
      lambda { @obj.to_set_hash }.should raise_error(MEACControl::Command::InvalidValue)
    end
  end

  describe "#to_get_string" do
    it "returns the string representation of command and the value '*'" do
      @obj.to_get_string.should == "#{@obj.command}=\"*\""
    end
  end

  describe "#to_get_hash" do
    it "returns the command and value as a hash" do
      @obj.to_get_hash.should == {@obj.command.to_sym => '*'}
    end
  end

  describe "#command_set?" do
    context "with value set to 'YES'" do
      it "returns true" do
        @obj.stub!(:value).and_return('YES')
        @obj.command_set?.should be_true
      end
    end

    context "with value set to an empty string" do
      it "returns false" do
        @obj.stub!(:value).and_return('')
        @obj.command_set?.should be_false
      end
    end

    context "with value set to nil" do
      it "returns false" do
        @obj.stub!(:value).and_return(nil)
        @obj.command_set?.should be_false
      end
    end
  end
end
