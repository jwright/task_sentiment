require "ruby/openai"

module TaskSentiment
  module Analyzers
    class OpenAiAnalyzer
      attr_reader :phrase

      def initialize(phrase)
        @phrase = phrase
      end

      def analyze
        client
          .completions(engine: "davinci",
                       parameters: default_parameters.merge(prompt: prompt))
          &.parsed_response
      end

      private

      def client
        @client ||= OpenAI::Client.new
      end

      def decoded_phrase(phrase, task = "")
        phrase_with_label(phrase) + task_with_label(task) + seperator(task)
      end

      def default_parameters
        {
          best_of: 1,
          frequency_penalty: 0,
          max_tokens: 30,
          presence_penalty: 0,
          stop: ["\n", "###", "Task:"],
          temperature: 0.3,
          top_p: 1
        }
      end

      def directions
        "Determine if the following phrases contain tasks and parse the due dates and assignments:"
      end

      def phrase_with_label(phrase)
        "Phrase: \"#{phrase}\"\n"
      end

      def prompt
        # TODO: This should come from some sort of database for the specific user
        <<-PROMPT.chomp
          #{directions}

          #{decoded_phrase("Can you get me the contract by tomorrow?", "Get me the contract, when: tomorrow")}
          #{decoded_phrase("That is really cool", "false")}
          #{decoded_phrase("Please send me the outline", "Send me the outline")}
          #{decoded_phrase("Julie, can you send Daryl the PR by Friday?", "Send Daryl the PR, when: Friday, assigned to: Julie")}
          #{decoded_phrase("@joe allow users to delete tasks by next week", "Allow users to delete tasks, when: next week, assigned to: Joe")}
          #{decoded_phrase("You can do that to your car.", "Do that to your car, when: today")}
          #{decoded_phrase("Prepare presentation", "Prepare presentation")}
          #{decoded_phrase("What time is it?", "false")}
          #{decoded_phrase("Can you send slides?", "Send slides, when: today")}
          #{decoded_phrase("Mike, can you buy milk?", "Buy milk, assigned to: Mike")}
          #{decoded_phrase(phrase)}
        PROMPT
      end

      def seperator(task)
        return "" if task.empty?

        "###"
      end

      def task_with_label(task)
        "Task:#{task}" + (task.empty? ? "" : "\n")
      end
    end
  end
end
