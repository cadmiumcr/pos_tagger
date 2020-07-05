require "./spec_helper"

text = "Two very decided failures, of late -- those of Mr. Henson and Sir George Cayley -- had much weakened the public interest in the subject of aerial navigation.  Mr. Henson's scheme (which at first was considered very feasible even by men of science,) was founded upon the principle of an inclined plane, started from an eminence by an extrinsic force, applied and continued by the revolution of impinging vanes, in form and number resembling the vanes of a windmill.  But, in all the experiments made with models at the Adelaide Gallery, it was found that the operation of these fans not only did not propel the machine, but actually impeded its flight. The only propelling force it ever exhibited, was the mere impetus acquired from the descent of the inclined plane;  and this impetus carried the machine farther when the vanes were at rest, than when they were in motion -- a fact which sufficiently demonstrates their inutility;  and in the absence of the propelling, which was also the sustaining power, the whole fabric would necessarily descend.  This consideration led Sir George Cayley to think only of adapting a propeller to some machine having of itself an independent power of support -- in a word, to a balloon;  the idea, however, being novel, or original, with Sir George, only so far as regards the mode of its application to practice.  He exhibited a model of his invention at the Polytechnic Institution.  The propelling principle, or power, was here, also, applied to interrupted surfaces, or vanes, put in revolution.  These vanes were four in number, but were found entirely ineffectual in moving the balloon, or in aiding its ascending power.  The whole project was thus a complete failure."

describe Cadmium::POSTagger do
  subject = Cadmium::POSTagger

  it "should initialize" do
    subject.new.language.should eq(:en)
  end

  it "should return an array of tagged tokens" do
    subject.new.tag(text)[85].univ_pos.should eq(:adp)
  end

  it "should translate a POS to its univ_pos equivalent" do
    Cadmium::Languages::English.new.tag_map["DT"][:univ_pos].should eq(:det)
  end
end

describe Cadmium::Document do
  subject = Cadmium::Document

  it "should initialize a Document, tokenize the sentences and pos tag the tokens" do
    # subject.new(text, pos_tag: true).sentences[3].tokens.first.pos.should eq("DT")
    # subject.new(text, pos_tag: true).sentences[3].tokens.first.univ_pos.should eq(:det)
    subject.new(text, pos_tag: true).sentences[3].tokens[4].morphology.should eq({:PronType => "prs"})
  end
end
