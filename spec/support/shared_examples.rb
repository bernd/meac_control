shared_examples_for "a class that includes MEACControl::Command::Generic" do
  it "includes MEACControl::Command::Generic" do
    @cmd.class.ancestors.should include(MEACControl::Command::Generic)
  end
end
