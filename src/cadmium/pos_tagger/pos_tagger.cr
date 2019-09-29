module Cadmium
  class POSTagger
    include Classifier
    include Tokenizer
    include Languages
    DEFAULT_CLASSIFIER = Viterbi.new
    DEFAULT_MODEL_PATH = "#{__DIR__}/data/en/pos.zip"
    property classifier
    property model : String
    property language : Symbol = :en

    def initialize(classifier = DEFAULT_CLASSIFIER, model = DEFAULT_MODEL_PATH, language = :en)
      @classifier = classifier
      @model = model
      @language = language
    end

    private def to_univ_pos(pos : String, tag_map) : String
    end

    def tag(tokens : Array(String) | String) : Array(Token)
      tokenizer = Cadmium::Tokenizer::Pragmatic.new(
        language: @language
      )
      tokens = tokenizer.tokenize(tokens) if tokens.is_a?(String)
      tag_map = get_language_by_code(@language).new.tag_map
      tagged_tokens = Array(Token).new
      @classifier.load_model(@model)
      @classifier.classify(tokens).to_a.each do |token_and_tag|
        tagged_tokens << Token.new(token_and_tag.first, token_and_tag.last.upcase, tag_map[token_and_tag.last.upcase][:univ_pos])
      end
      tagged_tokens
    end
  end
end
