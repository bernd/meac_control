require File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'spec_helper'))
require 'ostruct'
require 'meg50xml/command'

class Cmd; end

describe Meg50XML::Command::Generic do
  before(:each) do
    @obj = mock(Cmd, :command= => nil, :value= => nil, :value => "MyValue", :command => "MyCommand")
    @obj.send(:extend, Meg50XML::Command::Generic)
  end

  describe "#to_set_string" do
    it "returns the string representation of command and value" do
      @obj.to_set_string.should == "#{@obj.command}=\"#{@obj.value}\""
    end

    it "will raise an exception if value is nil" do
      @obj.stub!(:value).and_return(nil)
      lambda { @obj.to_set_string }.should raise_error(Meg50XML::Command::InvalidValue)
    end

    it "will raise an exception if value is an empty string" do
      @obj.stub!(:value).and_return('')
      lambda { @obj.to_set_string }.should raise_error(Meg50XML::Command::InvalidValue)
    end
  end

  describe "#to_get_string" do
    it "returns the string representation of command and the value '*'" do
      @obj.to_get_string.should == "#{@obj.command}=\"*\""
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

describe Meg50XML::Command::FanSpeed do
  before(:each) do
    @cmd = Meg50XML::Command::FanSpeed.new
  end

  it_should_behave_like "a class that includes Meg50XML::Command::Generic"

  it "has set the command to 'FanSpeed'" do
    @cmd.command.should == 'FanSpeed'
  end

  %w{low mid1 mid2 high auto}.each do |c|
    describe "##{c}" do
      it "sets the value to '#{c}'" do
        @cmd.send(c)
        @cmd.value.should == c
      end
    end
  end
end
