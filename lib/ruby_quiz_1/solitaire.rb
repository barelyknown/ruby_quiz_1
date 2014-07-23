class Solitaire

  attr_reader :deck

  def initialize(deck)
    @deck = deck
    jokers = deck.select { |c| c.is_a?(Joker) }
    raise ArgumentError, "#{jokers.size} jokers in the deck but 2 required" unless jokers.size == 2
    @joker_a, @joker_b = jokers
  end


  def next_key
    key = nil
    until key
      move_card(joker_a, 1)
      move_card(joker_b, 2)
      triple_cut
      count_cut
      key = current_letter
    end
    key
  end

private

  def joker_a_index
    deck.cards.index(joker_a)
  end

  def joker_b_index
    deck.cards.index(joker_b)
  end

  def joker_a
    @joker_a
  end

  def joker_b
    @joker_b
  end

  def max_index
    deck.size - 1
  end

  def move_card(card, distance)
    start_index = deck.cards.index(card)
    end_index = start_index + distance
    if end_index > max_index
      end_index = end_index % max_index
    end
    deck.cards.insert(end_index, deck.cards.delete(card))
  end

  def triple_cut
    c1, c2 = [joker_a_index, joker_b_index].sort
    new_end = []
    if c1 > 0
      new_end = deck.cards[0..(c1 - 1)]
    end
    new_middle = deck.cards[c1..c2]
    new_beginning = []
    if c2 < max_index
      new_beginning = deck.cards[(c2 + 1)..max_index]
    end
    deck.cards.replace(new_beginning + new_middle + new_end)
  end

  def count_cut
    deck.cards.last.total_value.times do
      deck.cards.insert(-2, deck.cards.shift)
    end
  end

  def current_letter
    letter_card = deck.cards[deck.cards[0].total_value]
    return nil if letter_card.is_a? Joker
    ("A".."Z").to_a[(letter_card.total_value % 26) - 1]
  end

end
