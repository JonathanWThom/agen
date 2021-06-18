# frozen_string_literal: true

RSpec.describe Agen::Shell do
  describe "#add_options" do
    subject { described_class.new(options).add_options }

    let(:options) { {} }
    let(:default_bash_options) do
      {
        histfile: Agen::BashOptions::HISTFILE,
        rcfile: Agen::BashOptions::RCFILE,
      }
    end
    let(:default_zsh_options) do
      {
        histfile: Agen::ZshOptions::HISTFILE,
        rcfile: Agen::ZshOptions::RCFILE,
      }
    end

    context "shell is zsh" do
      before do
        allow(ENV).to receive(:[]).with("SHELL").and_return("/usr/bin/zsh")
      end

      context "histfile is not specified" do
        it { is_expected.to eq default_zsh_options }
      end

      context "histfile is specified" do
        let(:path) { "/weird/history_path" }
        let(:options) { { histfile: path } }

        it { is_expected.to eq default_zsh_options.merge(histfile: path) }
      end

      context "rcfile is not specified" do
        it { is_expected.to eq default_zsh_options }
      end

      context "rcfile is specified" do
        let(:path) { "/weird/.rcfile_path" }
        let(:options) { { rcfile: path } }

        it { is_expected.to eq default_zsh_options.merge(rcfile: path) }
      end
    end

    context "shell is bash" do
      before do
        allow(ENV).to receive(:[]).with("SHELL").and_return("/usr/bin/bash")
      end

      context "histfile is not specified" do
        it { is_expected.to eq default_bash_options }
      end

      context "histfile is specified" do
        let(:path) { "/weird/history_path" }
        let(:options) { { histfile: path } }

        it { is_expected.to eq default_bash_options.merge(histfile: path) }
      end

      context "rcfile is not specified" do
        it { is_expected.to eq default_bash_options }
      end

      context "rcfile is specified" do
        let(:path) { "/weird/.rcfile_path" }
        let(:options) { { rcfile: path } }

        it { is_expected.to eq default_bash_options.merge(rcfile: path) }
      end
    end

    context "shell is not recognize" do
      before do
        allow(ENV).to receive(:[]).with("SHELL").and_return("/usr/bin/fish")
      end

      context "histfile is not specified" do
        it { is_expected.to be_falsey }
      end

      context "rcfile is not specified" do
        it { is_expected.to be_falsey }
      end

      context "histfile and rcfile are both specified" do
        let(:histfile) { "/weird/history_path" }
        let(:rcfile) { "/weird/.rcfile_path" }
        let(:options) { { histfile: histfile, rcfile: rcfile } }

        it { is_expected.to eq({ histfile: histfile, rcfile: rcfile}) }
      end
    end
  end
end
