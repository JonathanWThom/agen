# frozen_string_literal: true

RSpec.describe Agen::Runner do
  describe "#histfile" do
    subject { agen.histfile }

    context "default" do
      let(:agen) { described_class.new }

      it { is_expected.to eq "$HOME/.zsh_history" }
    end

    context "alternative file supplied" do
      let(:histfile) { "./fixtures/zsh_history" }
      let(:agen) { described_class.new(histfile: histfile) }

      it { is_expected.to eq histfile }
    end
  end

  describe "#rcfile" do
    subject { agen.rcfile }

    context "default" do
      let(:agen) { described_class.new }

      it { is_expected.to eq "$HOME/.zshrc" }
    end

    context "alternative file supplied" do
      let(:rcfile) { "./fixtures/zshrc" }
      let(:agen) { described_class.new(rcfile: rcfile) }

      it { is_expected.to eq rcfile }
    end
  end

  describe "#run" do
    it "writes a single alias to .zshrc based on .zsh_history" do
    end
  end
end
