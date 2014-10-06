class Card

  attr_reader :suit, :value
  def initialize(suit, value)
    @suit = suit
    @value = value
  end

  def value
    if ["J", "Q", "K"].include? @value
      value = 10
    elsif @value == "A"
      value = 11
    else
      @value
    end
  end

  def to_s
    "#{@value} of #{suit}"
  end
end

class Deck
cards = []

suits = [:hearts, :diamonds, :spades, :clubs]
suits.each do |suit|
  (2..10).each do |value|
    cards << Card.new(suit, value)
  end

  cards << Card.new(suit, "J")
  cards << Card.new(suit, "Q")
  cards << Card.new(suit, "K")
  cards << Card.new(suit, "A")
  end

end


class Hand
  attr_reader :cards

  def initialize
    @cards = []
  end

  def hit_me(deck)
    @cards << deck.cards.shift
  end

  def value
    value = 0
    cards.inject(0) do {|sum, card| sum += card.value }
    end
  end
end
#
class Game
  attr_reader :player_hand, :dealer_hand
  def initialize
    @player_hand = Hand.new
    @dealer_hand = Hand.new
    2.times { @player_hand.hit_me (@deck) }
    2.times { @dealer_hand.hit_me (@deck) }
  end

  def hit_me
    @player_hand.hit_me(@deck)
  end

  def stay
    @dealer_hand.dealer_play(@deck)
    @winner = determine.winner(@player_hand.value, @dealer_hand.value)
  end

  def status
    {:player_cards => @player_hand.cards,
     :player_value => @player_hand.value,
     :dealer_cards => @dealer_hand.cards,
     :dealer_value => @dealer_hand.value,
     :winner => @winner}
  end

  def determine_winner(player_value, dealer_value)
    player_value = @player_hand.value
    return :dealer if player_value > 21
    return :player if dealer_value > 21
    if player_value == dealer_value
      :push
    elsif player_value > dealer_value
      :player
    else
      :dealer
    end
  end

  def inspect
    status
  end
end
