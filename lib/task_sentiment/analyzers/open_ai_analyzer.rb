module TaskSentiment
  module Analyzers
    class OpenAiAnalyzer
      attr_reader :phrase

      def initialize(phrase)
        @phrase = phrase
      end

      def analyze
      end
    end
  end
end
