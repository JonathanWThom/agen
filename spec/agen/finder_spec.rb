# frozen_string_literal: true

RSpec.describe Agen::Finder do
  describe "#commands" do
    subject { described_class.new(histfile.path).commands }

    context "histfile contains nothing" do
      let(:histfile) { Tempfile.new }

      it { is_expected.to be_empty }
    end

    context "histfile contains one entry" do
      let(:histfile) do
        Tempfile.open do |f|
          f.puts(": 1619292473:0;cat ~/.zsh_history")
          f
        end
      end

      it { is_expected.to eq ["cat ~/.zsh_history"] }
    end

    context "histfile contains two entries" do
      let(:histfile) do
        Tempfile.open do |f|
          f.puts(": 1619292473:0;cat ~/.zsh_history")
          f.puts(": 1619291199:0;rake standard:fix")
          f
        end
      end

      it { is_expected.to eq ["rake standard:fix", "cat ~/.zsh_history"] }
    end

    context "histfile contains duplicate entries" do
      let(:histfile) do
        Tempfile.open do |f|
          f.puts(": 1619292473:0;rake standard:fix")
          f.puts(": 1619291199:0;rake standard:fix")
          f
        end
      end

      it { is_expected.to eq ["rake standard:fix"] }
    end

    context "histfile contains a tie for entry ranking" do
      subject { described_class.new(histfile).commands(1) }

      let(:histfile) do
        Tempfile.open do |f|
          f.puts(": 1619292473:0;cat ~/.zsh_history")
          f.puts(": 1619291199:0;rake standard:fix")
          f.puts(": 1619292473:0;cat ~/.zsh_history")
          f.puts(": 1619291199:0;rake standard:fix")
          f
        end
      end

      it { is_expected.to eq ["rake standard:fix"] }
    end

    context "limit is passed in" do
      subject { described_class.new(histfile).commands(1) }

      let(:histfile) do
        Tempfile.open do |f|
          f.puts(": 1619292473:0;cat ~/.zsh_history")
          f.puts(": 1619291199:0;rake standard:fix")
          f
        end
      end

      it { is_expected.to eq ["rake standard:fix"] }
    end

    # context "histfile contains very short entries" do
    # end

    # context "hitfile contains aliases" do
    ## does not create alias from alias, unless multiple
    # end

    # context "histfile contains more entries than desired number of results" do
    # end

    # context "histfile contains legitimate commands with ; in them" do
    # end
  end
end
