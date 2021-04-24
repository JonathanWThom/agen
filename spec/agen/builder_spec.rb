# frozen_string_literal: true

RSpec.describe Agen::Builder do
  describe "#aliases" do
    subject { described_class.new(commands).aliases }

    context "given a single command" do
      let(:commands) { ["git fetch upstream master"] }

      it { is_expected.to eq ["alias gfum=\"git fetch upstream master\""] }
    end

    context "given multiple commands" do
      let(:commands) do
        [
          "git fetch upstream master",
          "git push origin main"
        ]
      end

      it do
        is_expected.to eq [
          "alias gfum=\"git fetch upstream master\"",
          "alias gpom=\"git push origin main\""
        ]
      end
    end

    context "commands contain special characters" do
    end

    # context "given multiple commands that could potentially shorten to the same thing" do
    # end

    # context "given commands that shorten to aliases or commands that already exist" do
    # end
  end
end
