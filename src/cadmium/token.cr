module Cadmium
  # An individual token — i.e. a word, punctuation symbol, whitespace, etc
  class Token
    property verbatim : String
    property pos : String?
    property univ_pos : Symbol?
    property ner_tag : String?
    property morphology : Hash(Symbol, String | Symbol) | Hash(Symbol, Symbol) | Nil
    property is_start_sentence : Bool
    property is_stop_word : Bool
    property token_vector : Apatite::Vector(Float64)?
    property lemma : String?
    property is_punctuation : Bool
    property is_oov : Bool = false # Out of vocabulary (ie not present in the pos observation space)
    property language : Symbol     # language of the sentence / document the token is part of.

    def initialize(verbatim = "", pos = "", univ_pos = nil, morphology = nil, is_start_sentence = false, is_punctuation = false, language = :en)
      @verbatim = verbatim
      @pos = pos
      @univ_pos = univ_pos
      @morphology = morphology
      @is_start_sentence = is_start_sentence
      @is_punctuation = is_punctuation
      @language = language
      @is_stop_word = false
      @token_vector = nil
    end

    def size
      @verbatim.size
    end

    def is_base_form? : Bool
      # Check whether we're dealing with an uninflected paradigm, so we can
      # avoid lemmatization entirely.
      return false if @morphology.nil?
      # others = @morphology.keys.map { |key| !["Number", "POS", "VerbForm", "Tense"].includes?(key) }
      # return true if @univ_pos == :noun && @morphology["number"] == "sing"
      # return true if @univ_pos == :verb && @morphology["verbform"] == "inf"
      # return true if @univ_pos == :verb && (@morphology["verbform"] == "fin" && @morphology["tense"] == "pres" && @morphology["number"].nil? && others.empty?)
      # return true if @univ_pos == :adj && @morphology["degree"] == "pos"
      # return true if @morphology.values.includes?(["VerbForm_inf", "VerbForm_none", "Number_sing", "Degree_pos"])
      false
    end
  end
end
