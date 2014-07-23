class Card

  attr_reader :value, :suit

  def initialize(value, suit)
    raise ArgumentError unless (1..13).to_a.include? value
    @value, @suit = value, suit
  end

  def total_value
    value + suit.value
  end

end
