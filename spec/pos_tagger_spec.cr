require "./spec_helper"

describe Cadmium::POSTagger do
  subject = Cadmium::POSTagger.new

  it "should initialize" do
    subject.algorithm.should eq(Cadmium::Classifier::Viterbi)
  end
end
