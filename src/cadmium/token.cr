module Cadmium
  # An individual token — i.e. a word, punctuation symbol, whitespace, etc
  struct Token
    property verbatim : String = ""
    property pos : String = ""
    property univ_pos : String = ""
    property morphology : Hash(String, String) = {"" => ""}
    property is_start_sentence : Bool = false
    property vector : Vector? = nil
    property lemma : String?
    property is_punctuation : Bool = false
    property is _oov : Bool = false

    def initialize
    end

    def size
      self.verbatim.size
    end

    def self.is_base_form? : Bool
      # Check whether we're dealing with an uninflected paradigm, so we can
      # avoid lemmatization entirely.
      return false if self.morphology.nil?
      others = self.morphology.keys.map { |key| !["Number", "POS", "VerbForm", "Tense"].includes?(key) }
      return true if self.univ_pos == "noun" && self.morphology["number"] == "sing"
      return true if self.univ_pos == "verb" && self.morphology["verbform"] == "inf"
      return true if self.univ_pos == "verb" && (self.morphology["verbform"] == "fin" && self.morphology["tense"] == "pres" && self.morphology["number"].nil? && others.empty?) # cyclomatic complexity
      return true if self.univ_pos == "adj" && self.morphology["degree"] == "pos"
      return true if self.morphology.values.includes?(["VerbForm_inf", "VerbForm_none", "Number_sing", "Degree_pos"])
      false
    end
  end
end
