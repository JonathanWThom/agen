# frozen_string_literal: true

RSpec.describe Agen::CLI do
  describe "#run" do
    let(:runner) { double(Agen::Runner) }

    before do
      allow(Agen::Runner).to receive(:new).and_return(runner)
      allow(runner).to receive(:run)
    end

    it "calls Agen::Runner#run" do
      described_class.new.run

      expect(runner).to have_received(:run)
    end
  end
end
