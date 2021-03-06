# frozen_string_literal: true

RSpec.describe Agen::CLI do
  describe "#run" do
    let(:runner) { double(Agen::Runner) }

    before do
      ARGV.clear
      allow(ENV).to receive(:[]).and_return("/usr/bin/zsh")
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

        expect(
          Agen::Runner
        ).to have_received(:new).with(
          number: 10,
          histfile: Agen::ZshOptions::HISTFILE,
          rcfile: Agen::ZshOptions::RCFILE
        )
        expect(runner).to have_received(:run)
      end
    end

    context "auto option is passed" do
      before { ARGV.replace(["-a"]) }

      it "passes option to Agen::Runner" do
        described_class.new.run

        expect(
          Agen::Runner
        ).to have_received(:new).with(
          auto: true,
          histfile: Agen::ZshOptions::HISTFILE,
          rcfile: Agen::ZshOptions::RCFILE
        )
        expect(runner).to have_received(:run)
      end
    end

    context "histfile option is passed" do
      let(:histfile) { Agen::BashOptions::HISTFILE }

      before { ARGV.replace(["-s", histfile]) }

      it "passes option to Agen::Runner" do
        described_class.new.run

        expect(
          Agen::Runner
        ).to have_received(:new).with(
          histfile: histfile,
          rcfile: Agen::ZshOptions::RCFILE
        )
        expect(runner).to have_received(:run)
      end
    end

    context "rcfile option is passed" do
      let(:rcfile) { Agen::BashOptions::RCFILE }

      before { ARGV.replace(["-r", rcfile]) }

      it "passes option to Agen::Runner" do
        described_class.new.run

        expect(
          Agen::Runner
        ).to have_received(:new).with(
          histfile: Agen::ZshOptions::HISTFILE,
          rcfile: rcfile
        )
        expect(runner).to have_received(:run)
      end
    end
  end
end
