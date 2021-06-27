# frozen_string_literal: true

RSpec.describe Agen::Finder do
  describe "#commands" do
    subject do
      described_class.new(histfile.path, config_file.path).commands
    end

    let(:config_file) { Tempfile.new }

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
      subject { described_class.new(histfile).commands(limit: 1) }

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
      subject { described_class.new(histfile).commands(limit: 1) }

      let(:histfile) do
        Tempfile.open do |f|
          f.puts(": 1619292473:0;cat ~/.zsh_history")
          f.puts(": 1619291199:0;rake standard:fix")
          f
        end
      end

      it { is_expected.to eq ["rake standard:fix"] }
    end

    context "commands are shorter than 6 characters" do
      let(:histfile) do
        Tempfile.open do |f|
          f.puts(": 1619292473:0;bundle exec rake release")
          f.puts(": 1619291199:0;ls")
          f
        end
      end

      it { is_expected.to eq ["bundle exec rake release"] }
    end

    context "command has been previously ignored" do
      let(:config_file) do
        Tempfile.open do |f|
          f.puts("cat ~/.zsh_history")
          f
        end
      end

      let(:histfile) do
        Tempfile.open do |f|
          f.puts(": 1619292473:0;cat ~/.zsh_history")
          f
        end
      end

      it { is_expected.to be_empty }
    end
  end
end
