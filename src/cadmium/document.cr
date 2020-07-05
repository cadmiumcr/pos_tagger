module Cadmium
  class Corpus
    property documents : Array(Document)

    def initialize(document)
      @documents += document
    end

    def size
      @documents.sum { |document| document.size }
    end
  end

  # a document which contains human text.
  class Document
    property verbatim : String
    property language : Symbol
    property sentences : Array(Sentence)

    def initialize(verbatim = "", language = :en, pos_tag = false)
      @verbatim = verbatim
      @language = language
      sentences = @verbatim.tokenize(Tokenizer::Sentence)
      @sentences = sentences.map do |sentence|
        Sentence.new(verbatim: sentence, language: @language, pos_tag: pos_tag)
      end
    end

    def size
      self.verbatim.size
    end
  end

  class Sentence
    property verbatim : String
    property language : Symbol
    property tokens : Array(Token)

    def initialize(verbatim = "", language = :en, pos_tag = false)
      @tokens = [Token.new]
      @verbatim = verbatim
      @language = language
      tokenizer = Cadmium::Tokenizer::Pragmatic.new(
        language: @language
      )
      tokens = tokenizer.tokenize(@verbatim) unless pos_tag
      pos_tagger = Cadmium::POSTagger.new(language: @language)
      @tokens = pos_tagger.tag(@verbatim) if pos_tag
      @tokens = tokens.map { |token| Token.new(verbatim: token, language: @language) } if tokens.is_a?(Array(String))
      @tokens.first.is_start_sentence = true
      if pos_tag
        @tokens.each do |token|
          token.is_oov = true if pos_tagger.classifier.observation_space.includes?(token.verbatim)
        end
      end
    end

    def size
      self.verbatim.size
    end
  end
end
