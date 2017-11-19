class Card
  attr_reader :rank, :suit, :value

  RANKS = %w[2 3 4 5 6 7 8 9 10 J Q K A]
  SUITS = ['♠', '♣', '♦', '♥']

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def value
    return @rank if %w[2 3 4 5 6 7 8 9 10].include?(rank)
    return 10 if %w[J Q K].include?(rank)
    return 11 if rank == 'A'
    @value
  end

  def to_s
    "#{rank}" "#{suit}"
  end
end
