module RubyQuiz1
  describe Solitaire do
    context "for a standard deck" do
      subject do
        described_class.new StandardDeck.new
      end

      it "calculates the correct first 10 keys" do
        %w(D W J X H Y R F D G).each do |key|
          expect(subject.next_key).to eq key
        end
      end
    end

  end
end
