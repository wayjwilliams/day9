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

  @@cards = []

  def self.build_cards
    [:hearts, :diamonds, :spades, :clubs].each do |suit|
      (2..10).each do |value|
        @@cards << Card.new(suit, value)
      end
      ["J", "Q", "K", "A"].each do |facecard|
        @@cards << Card.new(suit, facecard)
      end
    end
    cards
  end

  @@cards.shuffle!
  end

  def self.deal
    @@cards.shift
  end
end

class Hand
  attr_reader :cards, :value

  def initialize
    @cards = []
    @total = 0
    @cards = Deck.deal
    @total = 0
    @cards = Deck.deal
  end

  def hit_me
    @cards << deck.cards.shift
  end
end

class Game
  attr_accessor :player_hand, :dealer_hand
  def initialize
    @player_hand = Hand.new
    @dealer_hand = Hand.new
    @value = 0
  end

  def hit
    @player_hand.hit_me
  end

  def stay
    determine_winner
  end

  def dealer_turn
    if @dealer_hand.value < 16
      @dealer_hand.hit_me
    else
      stay
    end
  end

  def player_turn
    puts "Your cards are #{@player_hand}. Hit(h) or stay(s)?"
    hit_or_stay = gets.chomp
    if hit_or_stay == "h"
      hit
    else
      stay
    end
  end

  def determine_winner(player_value, dealer_value)
    if player_value > 21
      puts "You busted. Play again!"
    elsif dealer_value > 21
      puts "You win!"
    elsif player_value == dealer_value
      puts "Tie. Play again!"
    elsif player_value > dealer_value
      puts "You win!"
    else
      puts "Dealer wins. Play again!"
    end
  end
end
end


Deck.build_cards
Deck.deal
game = Game.new

# do the dew
