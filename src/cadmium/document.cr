module Cadmium
  struct Corpus
    property documents : Array(Document)

    def size
      self.documents.map { |document| document.verbatim }.join.size
    end
  end

  # a document which contains human text.
  struct Document
    property verbatim : String
    property language : Symbol
    property sentences : Array(String)
    property tokens : Array(Token)
    property readability : Float64
  end

  def size
    self.verbatim.size
  end
end
