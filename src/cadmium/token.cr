module Cadmium
  # An individual token — i.e. a word, punctuation symbol, whitespace, etc
  struct Token
    property verbatim : String
    property pos : String
    property univ_pos : Symbol
    property morphology : Symbol | String | Nil
    property is_start_sentence : Bool
    # property vector : Vector? = nil
    property lemma : String?
    property is_punctuation : Bool
    property is_oov : Bool = false
    property language : Symbol # language of the document the token is part of.

    def initialize(verbatim = "", pos = "", univ_pos = :none, morphology = :none, is_start_sentence = false, is_punctuation = false, language = :en)
      @verbatim = verbatim
      @pos = pos
      @univ_pos = univ_pos
      @morphology = morphology
      @is_start_sentence = is_start_sentence
      @is_punctuation = is_punctuation
      @language = language
    end

    def size
      self.verbatim.size
    end

    def self.is_base_form? : Bool
      # Check whether we're dealing with an uninflected paradigm, so we can
      # avoid lemmatization entirely.
      return false if self.morphology.nil?
      others = self.morphology.keys.map { |key| !["Number", "POS", "VerbForm", "Tense"].includes?(key) }
      return true if self.univ_pos == :noun && self.morphology["number"] == "sing"
      return true if self.univ_pos == :verb && self.morphology["verbform"] == "inf"
      return true if self.univ_pos == :verb && (self.morphology["verbform"] == "fin" && self.morphology["tense"] == "pres" && self.morphology["number"].nil? && others.empty?) # cyclomatic complexity
      return true if self.univ_pos == :adj && self.morphology["degree"] == "pos"
      return true if self.morphology.values.includes?(["VerbForm_inf", "VerbForm_none", "Number_sing", "Degree_pos"])
      false
    end
  end
end
