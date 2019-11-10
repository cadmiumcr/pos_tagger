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

    private def to_univ_pos(pos : String, tag_map) : Symbol
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
        tag_map_infos = tag_map[token_and_tag.last.upcase]
        univ_pos = tag_map_infos[:univ_pos]
        tag_map_infos = tag_map_infos.to_h
        tag_map_infos.shift
        morphology = tag_map_infos
        tagged_tokens << Token.new(verbatim: token_and_tag.first, pos: token_and_tag.last.upcase, univ_pos: univ_pos, morphology: morphology)
      end
      tagged_tokens
    end
  end
end
