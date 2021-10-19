require "webmock/rspec"
require "task_sentiment/analyzers/open_ai_analyzer"

RSpec.describe TaskSentiment::Analyzers::OpenAiAnalyzer do
  let(:api_token) { "TOKEN" }
  let(:phrase) { "Do something tomorrow" }

  subject(:analyzer) { described_class.new(phrase) }

  before do
    allow(ENV).to receive(:[]).with("OPENAI_ACCESS_TOKEN").and_return(api_token)
  end

  describe "#initialize" do
    it "initializes with a phrase" do
      expect(described_class.new(phrase).phrase).to eq phrase
    end
  end

  describe "#analyze" do
    let(:prompt) do
      <<-PROMPT
        Determine if the following phrases contain tasks and parse the due dates and assignments:

        Phrase: "Can you get me the contract by tomorrow?"
        Task: Get me the contract, due: tomorrow
        ###
        Phrase: "That is really cool"
        Task: false
        ###
        Phrase: "Please send me the outline"
        Task: Send me the outline
        ###
        Phrase: "Julie, can you send Daryl the PR by Friday?"
        Task: Send Daryl the PR, due: Friday, assigned to: Julie
        ###
        Phrase: "You can do that to your car."
        Task: Do that to your car, due: today
        ###
      PROMPT
    end
    let(:phrase) { "@joe allow users to delete tasks by next week" }

    before do
      stub_request :post, "https://api.openai.com/v1/engines/davinci/completions"
    end

    xit "sends the correct query to OpenAI" do
      # TODO: This is not matching on the prompt
      analyzer.analyze

      assert_requested :post, "https://api.openai.com/v1/engines/davinci/completions",
        headers: { "Authorization" => "Bearer #{api_token}", "Content-Type" => "application/json" },
        body: hash_including({ best_of: 1,
                frequency_penalty: 0,
                max_tokens: 30,
                presence_penalty: 0,
                stop: ["\n", "###", "Task:"],
                temperature: 0.3,
                top_p: 1,
                prompt: "#{prompt}\nPhrase: \"#{phrase}\nTask:"
              })
    end
  end
end
