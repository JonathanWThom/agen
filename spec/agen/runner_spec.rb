# frozen_string_literal: true

require "tempfile"

RSpec.describe Agen::Runner do
  describe "#histfile" do
    subject { agen.histfile }

    context "default" do
      let(:agen) { described_class.new }

      it { is_expected.to eq "#{Dir.home}/.zsh_history" }
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

      it { is_expected.to eq "#{Dir.home}/.zshrc" }
    end

    context "alternative file supplied" do
      let(:rcfile) { "./fixtures/zshrc" }
      let(:agen) { described_class.new(rcfile: rcfile) }

      it { is_expected.to eq rcfile }
    end
  end

  describe "#run" do
    subject do
      execute!
      rcfile.open.read
    end

    let(:execute!) do
      described_class.new(
        histfile: histfile.path,
        rcfile: rcfile.path,
        auto: true
      ).run
    end

    let(:rcfile) { Tempfile.new }

    context "single listing in histfile" do
      let(:histfile) do
        Tempfile.open do |f|
          f.write(": 1619287411:0;git checkout main")
          f
        end
      end

      it { is_expected.to eq "alias gcm=\"git checkout main\"\n" }
    end

    context "rcfile has content already" do
      let(:histfile) do
        Tempfile.open do |f|
          f.write(": 1619287607:0;bundle install")
          f
        end
      end

      let(:rcfile) do
        Tempfile.open do |f|
          f.puts("export FOO=\"bar\"")
          f
        end
      end

      it { is_expected.to eq "export FOO=\"bar\"\nalias bi=\"bundle install\"\n" }
    end

    context "multiple aliases to .zshrc based on .zsh_history" do
      let(:histfile) do
        Tempfile.open do |f|
          f.puts(": 1619287607:0;bundle install")
          f.puts(": 1619287607:0;bundle exec rails s")
          f
        end
      end

      it do
        is_expected.to eq(
          "alias bers=\"bundle exec rails s\"\nalias bi=\"bundle install\"\n"
        )
      end
    end

    context ".zsh_history has many entries with different frequencies" do
      let(:histfile) { File.open("./spec/fixtures/zsh_history") }

      it { is_expected.to eq File.read("./spec/fixtures/zshrc") }
    end

    context "alias already exists in rcfile" do
      let(:histfile) do
        Tempfile.open do |f|
          f.write(": 1619287607:0;bundle install")
          f
        end
      end

      let(:aliaz) { "alias bi=\"bundle install\"" }
      let(:rcfile) do
        Tempfile.open do |f|
          f.write(aliaz)
          f
        end
      end

      it { is_expected.to eq aliaz }
    end

    context "number is passed as option" do
      let(:limit) { 10 }
      let(:histfile) { Tempfile.new }
      let(:execute!) do
        described_class.new(
          histfile: histfile.path,
          rcfile: rcfile.path,
          number: limit
        ).run
      end
      let(:finder) { instance_double(Agen::Finder) }

      before do
        allow(Agen::Finder).to receive(:new).and_return(finder)
        allow(finder).to receive(:commands).and_return([])
      end

      it "calls Finder with number as limit" do
        execute!

        expect(finder).to have_received(:commands).with(limit: limit)
      end
    end

    context "auto is left to default of false" do
      subject do
        execute!
        rcfile.open.read
      end

      let(:rcfile) { Tempfile.new }

      let(:histfile) do
        Tempfile.open do |f|
          f.write(": 1619287411:0;git checkout main")
          f
        end
      end

      let(:execute!) do
        described_class.new(
          histfile: histfile.path,
          rcfile: rcfile.path
        ).run
      end

      let(:written_alias) { "alias gcm=\"git checkout main\"\n" }

      before { $stdin = StringIO.new(input) }
      after { $stdin = STDIN }

      context "input is 'y'" do
        let(:input) { "y" }

        it { is_expected.to eq written_alias }
      end

      context "input is 'n'" do
        let(:input) { "n" }

        it { is_expected.to eq "" }
      end

      context "input is 'm'" do
        let(:input) { "m\nhello" }

        it { is_expected.to eq "alias hello=\"git checkout main\"\n" }
      end

      context "input is something other than 'n' or 'm'" do
        let(:input) { "blah" }

        it { is_expected.to eq written_alias }
      end
    end
  end
end
