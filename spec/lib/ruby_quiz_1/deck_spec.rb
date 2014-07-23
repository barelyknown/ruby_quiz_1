module RubyQuiz1
  describe Deck do

    it "is enumerable" do
      card = double(Card, total_value: 1)
      expect(card).to receive(:total_value)
      subject.cards << card
      subject.each { |c| c.total_value }
    end

    it "calculates its size" do
      subject.cards << double(Card)
      expect(subject.size).to eq 1
    end

  end
end
