module TaskSentiment
  class Analyzer
    attr_reader :phrase

    def initialize(phrase)
      @phrase = phrase
    end
  end
end
