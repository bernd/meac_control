require File.expand_path(File.join(File.dirname(__FILE__), '..', '..', '..', 'spec_helper'))
require 'meac_control/command/generic'

class Cmd < MEACControl::Command::Generic
  def initialize
    @command = "MyCommand"
    @value = "MyValue"
  end

  def on
    @value = 'ON'
  end
end

describe MEACControl::Command::Generic do
  before(:each) do
    @obj = Cmd.new
  end

  describe ".request" do
    it "returns a new frozen object" do
      Cmd.request.should be_frozen
    end

    it "does not allow modifications" do
      lambda { Cmd.request.on }.should raise_error
    end
  end

  describe "#hash_for" do
    it "will raise an exception if it's called without argument" do
      lambda { @obj.hash_for }.should raise_error(ArgumentError)
    end

    context "with the :get argument" do
      it "returns a hash with the command name as key and a value of '*'" do
        @obj.hash_for(:get).should == {@obj.command.to_sym => '*'}
      end
    end

    context "with the :set argument" do
      it "returns a hash with the command as key and the command value as value" do
        @obj.hash_for(:set).should == {@obj.command.to_sym => @obj.value}
      end

      it "will raise an exception if value is nil" do
        @obj.stub!(:value).and_return(nil)
        lambda { @obj.hash_for(:set) }.should raise_error(MEACControl::Command::InvalidValue)
      end

      it "will raise an exception if value is an empty string" do
        @obj.stub!(:value).and_return('')
        lambda { @obj.hash_for(:set) }.should raise_error(MEACControl::Command::InvalidValue)
      end
    end

    context "with an unknown argument" do
      it "will raise an exception" do
        lambda { @obj.hash_for(:foobar_unknown) }.should raise_error(MEACControl::Command::InvalidMode)
      end
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
