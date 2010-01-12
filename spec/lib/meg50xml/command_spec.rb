require File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'spec_helper'))
require 'ostruct'
require 'meg50xml/command'

describe Meg50XML::Command::Generic do
  before(:each) do
    @obj = OpenStruct.new
    @obj.send(:extend, Meg50XML::Command::Generic)
  end

  describe "#to_s" do
    it "returns the string representation of command and value" do
      @obj.command = "MyCommand"
      @obj.value = "MyValue"
      @obj.to_s.should == "#{@obj.command}=\"#{@obj.value}\""
    end
  end

  describe "#command_set?" do
    context "with value set to 'YES'" do
      it "returns true" do
        @obj.value = 'YES'
        @obj.command_set?.should be_true
      end
    end

    context "with value set to an empty string" do
      it "returns false" do
        @obj.value = ''
        @obj.command_set?.should be_false
      end
    end

    context "with value set to nil" do
      it "returns false" do
        @obj.value = nil
        @obj.command_set?.should be_false
      end
    end
  end
end

shared_examples_for "a class that includes Meg50XML::Command::Generic" do
  it "includes Meg50XML::Command::Generic" do
    @cmd.class.ancestors.should include(Meg50XML::Command::Generic)
  end
end

describe Meg50XML::Command::Drive do
  before(:each) do
    @cmd = Meg50XML::Command::Drive.new
  end

  it_should_behave_like "a class that includes Meg50XML::Command::Generic"

  it "has set the command to 'Drive'" do
    @cmd.command.should == 'Drive'
  end

  describe "#on" do
    it "sets the value to 'ON'" do
      @cmd.on
      @cmd.value.should == 'ON'
    end
  end

  describe "#off" do
    it "sets the value to 'OFF'" do
      @cmd.off
      @cmd.value.should == 'OFF'
    end
  end
end
