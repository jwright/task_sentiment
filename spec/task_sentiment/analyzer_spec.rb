require "task_sentiment/analyzer"

RSpec.describe TaskSentiment::Analyzer do
  describe "#initialize" do
    let(:phrase) { "Do something tomorrow" }

    it "initializes with a phrase" do
      expect(described_class.new(phrase).phrase).to eq phrase
    end
  end
end
