module RubyQuiz1
  class StandardDeck < Deck

    def initialize
      add_cards
      super
    end

  private

    def add_cards
      {club: 0, diamond: 13, heart: 26, spade: 39}.each do |suit_name, suit_value|
        suit = Suit.new(suit_name, suit_value)
        (1..13).each do |card_value|
          cards << Card.new(card_value, suit)
        end
      end
      2.times { cards << Joker.new }
    end

  end
end
