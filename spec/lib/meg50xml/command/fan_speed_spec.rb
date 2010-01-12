require File.expand_path(File.join(File.dirname(__FILE__), '..', '..', '..', 'spec_helper'))
require 'meg50xml/command/fan_speed'

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
