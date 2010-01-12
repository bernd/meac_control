shared_examples_for "a class that includes Meg50XML::Command::Generic" do
  it "includes Meg50XML::Command::Generic" do
    @cmd.class.ancestors.should include(Meg50XML::Command::Generic)
  end
end
