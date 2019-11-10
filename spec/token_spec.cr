require "./spec_helper"

describe Cadmium::Token do
  subject = Cadmium::Token
  it "should initialize a Token with only a string" do
    subject.new("test").should be_a(Cadmium::Token)
    subject.new("test").verbatim.should eq("test")
    subject.new("test").is_base_form?.should be_false
  end
end
