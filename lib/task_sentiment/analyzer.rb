module TaskSentiment
  class Analyzer
    attr_reader :phrase

    def initialize(phrase)
      @phrase = phrase
    end

    def analyze(analyzer = :open_ai)
      define_analyzer(analyzer).new(phrase).analyze
    end

    private

    def analyzer_class_name(analyzer)
      "#{analyzer}_analyzer".split("_").collect(&:capitalize).join
    end

    def define_analyzer(analyzer)
      TaskSentiment::Analyzers.const_get(analyzer_class_name(analyzer))
    end
  end
end
