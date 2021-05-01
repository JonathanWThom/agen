# frozen_string_literal: true

RSpec.describe Agen::CLI do
  describe "#run" do
    let(:runner) { double(Agen::Runner) }

    before do
      ARGV.clear
      allow(Agen::Runner).to receive(:new).and_return(runner)
      allow(runner).to receive(:run)
    end

    it "calls Agen::Runner#run" do
      described_class.new.run

      expect(runner).to have_received(:run)
    end

    context "number option is passed" do
      before { ARGV.replace(["-n", "10"]) }

      it "passes option to Agen::Runner" do
        described_class.new.run

        expect(Agen::Runner).to have_received(:new).with(number: 10)
        expect(runner).to have_received(:run)
      end
    end

    context "auto option is passed" do
      before { ARGV.replace(["-a"]) }

      it "passes option to Agen::Runner" do
        described_class.new.run

        expect(Agen::Runner).to have_received(:new).with(auto: true)
        expect(runner).to have_received(:run)
      end
    end
  end
end
