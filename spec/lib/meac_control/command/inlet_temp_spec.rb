require File.expand_path(File.join(File.dirname(__FILE__), '..', '..', '..', 'spec_helper'))
require 'meac_control/command/inlet_temp'

describe MEACControl::Command::InletTemp do
  before(:each) do
    @cmd = MEACControl::Command::InletTemp.new
  end

  it_should_behave_like "a class that includes MEACControl::Command::Generic"

  it "has set the command to 'InletTemp'" do
    @cmd.command.should == 'InletTemp'
  end
end
