module RubyQuiz1
  class Deck
    include Enumerable

    def cards
      @cards ||= []
    end

    def each
      cards.each { |card| yield card }
    end

    def size
      cards.size
    end

  end
end

require_relative "decks/standard_deck"
