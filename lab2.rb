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
  attr_accessor :cards, :deal

  def initialize
    @cards = []
    suits = [:hearts, :diamonds, :spades, :clubs]

    suits.each do |suit|
      (2..10).each do |value|
        @cards << Card.new(suit, value)
      end
      ["J", "Q", "K", "A"].each do |facecard|
        @cards << Card.new(suit, facecard)
      end
    end
  end

  def shuffle
    @cards.shuffle!
  end

  def deal
    @cards.shift
  end
end


class Hand
  attr_accessor :cards, :deck

  def initialize
    @cards = []
    @deck = Deck.new
  end

  def total
    @cards.inject(0) do |sum, card|
      sum += card.value
    end
  end
end

class Game

  player = Hand.new
  dealer = Hand.new
  deck = Deck.new
  deck.shuffle

  2.times do
    player.cards << deck.deal
  end

  2.times do
    dealer.cards << deck.deal
  end

  puts "You have"
  puts "#{player.cards[0]} and #{player.cards[1]}"
  puts "for a total of: #{player.total}"
  puts "---------------"
  puts "Dealer is showing"
  puts dealer.cards[0]
  puts "---------------"

  until dealer.total > 16
    dealer.cards << deck.deal
  end

  puts "Hit? (y/n)"
  answer = gets.chomp
  until answer.downcase == "n" || player.total > 21
    player.cards << deck.deal
    puts "You have: "
    puts player.cards
    puts "Your new total is #{player.total}"
    if player.total < 21
      puts "Hit again? (y/n)"
      answer = gets.chomp
    end
  end

  if player.total > 21
    puts "You busted. So sad! Try again!"
    answer = gets.chomp
  elsif player.total > dealer.total || player.total == 21
    puts "You win! Dealer's hand was: #{dealer.cards}"
  elsif dealer.total > 21
    puts "You win! Dealer busts with #{dealer.cards}."
  elsif dealer.total == player.total
    puts "It's a draw. Play again!"
  else
    puts "You Lose. Dealer beat you with #{dealer.cards}"
  end
end
