# frozen_string_literal: true

RSpec.describe Agen::CLI do
  describe "#run" do
    let(:runner) { double(Agen::Runner) }

    before do
      allow(Agen::Runner).to receive(:new).and_return(runner)
      allow(runner).to receive(:call)
    end

    it "calls Agen::Runner#call" do
      described_class.new.run

      expect(runner).to have_received(:call)
    end
  end
end
