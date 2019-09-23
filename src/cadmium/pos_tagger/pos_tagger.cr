module Cadmium
  class POSTagger
    include Token
    property algorithm : Cadmium::Classifier = Cadmium::Classifier::Viterbi.new

    def initialize(algorithm = @@algorithm)
    end

    def tag(token : String = "") : Token
      tagged_token = Token.new(token)
    end
  end
end
