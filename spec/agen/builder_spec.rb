# frozen_string_literal: true

RSpec.describe Agen::Builder do
  describe "#aliases" do
    subject { described_class.new(commands, "spec/fixtures/zshrc").aliases }

    context "given a single command" do
      let(:commands) { ["git fetch upstream master"] }

      it do
        is_expected.to eq(
          [
            {
              alias: "gfum",
              command: commands[0],
              full_alias: "alias gfum=\"git fetch upstream master\""
            }
          ]
        )
      end
    end

    context "given multiple commands" do
      let(:commands) do
        [
          "git fetch upstream master",
          "git push origin main"
        ]
      end

      it do
        is_expected.to eq(
          [
            {
              alias: "gfum",
              command: commands[0],
              full_alias: "alias gfum=\"git fetch upstream master\""
            },
            {
              alias: "gpom",
              command: commands[1],
              full_alias: "alias gpom=\"git push origin main\""
            }
          ]
        )
      end
    end

    context "potential alias already exists on system" do
      let(:commands) { ["loan shark"] } # ls

      it do
        is_expected.to eq(
          [
            {
              alias: "lss",
              command: commands[0],
              full_alias: "alias lss=\"loan shark\""
            }
          ]
        )
      end
    end

    context "given multiple commands that could potentially shorten to the same thing" do
      let(:commands) { ["brew update", "brew upgrade"] }

      it do
        is_expected.to eq(
          [
            {
              alias: "bu",
              command: commands[0],
              full_alias: "alias bu=\"brew update\""
            },
            {
              alias: "buu",
              command: commands[1],
              full_alias: "alias buu=\"brew upgrade\""
            }
          ]
        )
      end
    end
  end

  describe "#construct_alias" do
    subject { described_class.new.construct_alias("foo", "bar") }

    it { is_expected.to eq "alias foo=\"bar\"" }
  end
end
