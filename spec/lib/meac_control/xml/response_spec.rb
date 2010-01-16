require File.expand_path(File.join(File.dirname(__FILE__), '..', '..', '..', 'spec_helper'))
require 'meac_control/xml/response'

describe MEACControl::XML::Response do
  before(:each) do
    @string_ok = <<-__EOF
<?xml version="1.0" encoding="UTF-8"?>
<Packet>
  <Command>getResponse</Command>
  <DatabaseManager>
    <Mnet Drive="OFF" Group="31" />
  </DatabaseManager>
</Packet>
    __EOF
    @string_error = <<-__EOF
<?xml version="1.0" encoding="UTF-8"?>
<Packet>
  <Command>geErrorResponse</Command>
  <DatabaseManager>
    <Mnet Drive="*" Group="31" />
    <ERROR Point="geRequest" Code="0102" Message="Insufficiency Attribute" />
  </DatabaseManager>
</Packet>
    __EOF
  end

  it "creates a response from a xml string" do
    response = MEACControl::XML::Response.new(@string_ok)
    response.xml.should  be_a(Nokogiri::XML::Document)
  end

  describe "#ok?" do
    it "returns true if the response has no error messages" do
      response = MEACControl::XML::Response.new(@string_ok)
      response.ok?.should be_true
    end

    it "returns false if the response has an error message" do
      response = MEACControl::XML::Response.new(@string_error)
      response.ok?.should be_false
    end
  end

  describe "#errors?" do
    it "returns true if the response has an error message" do
      response = MEACControl::XML::Response.new(@string_error)
      response.errors?.should be_true
    end

    it "returns false if the response has no error message" do
      response = MEACControl::XML::Response.new(@string_ok)
      response.errors?.should be_false
    end
  end

  describe "#errors" do
    it "returns a list of hashes with the error messages" do
      response = MEACControl::XML::Response.new(@string_error)
      response.errors.should == [{'Point' => 'geRequest', 'Code' => '0102', 'Message' => 'Insufficiency Attribute'}]
    end
  end

  describe "#error_messages" do
    it "returns a list of error message strings" do
      response = MEACControl::XML::Response.new(@string_error)
      response.error_messages.should == ['Insufficiency Attribute']
    end
  end
end
