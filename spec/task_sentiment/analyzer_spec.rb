require "task_sentiment"

RSpec.describe TaskSentiment::Analyzer do
  let(:phrase) { "Do something tomorrow" }

  subject(:analyzer) { described_class.new(phrase) }

  describe "#initialize" do
    it "initializes with a phrase" do
      expect(described_class.new(phrase).phrase).to eq phrase
    end
  end

  describe "#analyze" do
    let(:result) { { task: "Do something" } }

    before { allow_any_instance_of(TaskSentiment::Analyzers::OpenAiAnalyzer).to receive(:analyze).and_return(result) }

    it "delegates to the analyzer" do
      expect(TaskSentiment::Analyzers::OpenAiAnalyzer).to receive(:new).with(phrase).and_call_original

      analyzer.analyze
    end

    it "returns the results from the analyzer" do
      expect(analyzer.analyze).to eq result
    end
  end
end
