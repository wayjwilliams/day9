
class Card

  attr_accessor :suit, :value

  def initialize(suit, value)
    @value = value
    @suit = suit
  end

  def to_s
    p "Your card is #{@value}-#{@suit}"
  end

  def face_card
    @value = 10 if ["Jack", "Queen", "King"].include? @value
    @value = 11 if @value == "Ace"
    return @value
  end

end



class Deck

  @@cards = []

  def self.build_cards

    [:spade, :club, :diamond, :heart].each do |suit|
      (2..10).each do |value|
        @@cards << Card.new(suit, value)
      end
      ["Jack", "Queen", "King", "Ace"].each do |facecard|
        @@cards << Card.new(suit, facecard)
      end
    end

  end


  def self.deal_card
    @@cards.shuffle.shift
  end
end

class Hand
    attr_accessor :cards, :total

  def initialize(name)
    @name = name
    @cards = []
    @total = 0
    @cards << Deck.deal_card
    @cards << Deck.deal_card
    @total = 0
  end

  def show
    @cards.each do |card|
      new_card = Card.new(card.suit, card.value)
      new_card.to_s
      new_card.face_card
      @total += new_card.value
    end
    p "#{@name} total is #{@total}"
  end

  def hit
    card = Deck.deal_card
    new_card = Card.new(card.suit, card.value)
    new_card.to_s
    new_card.face_card

    @total += new_card.value
    p "#{@name} total is #{@total}"
  end

end

class Game
  attr_accessor :cards_player
  def initialize
    @player = Hand.new "Thanh"
    @dealer = Hand.new "Dealer"
    @count = 0
  end

  def pass_card
    p "Dealer first card is #{@dealer.cards.first.value}-#{@dealer.cards.first.suit}"
    p "*********************"

    @player.show

    if @player.total == 21
      p "YOU HAVE BLACKJACK"
      return
    end

    if @player.total == 22
      p "You busted. You loose"
      return
    end

    p "Do you want to hit(h) or stay(s)"
    user = gets.chomp

    p "*********************"

    until user == "s"
      @player.hit
      @count += 1

      if @player.total > 21
        p "You busted. You loose"
        return
      end

      p "Your total is #{@player.total}"

      p "Do you want to hit(h) or stay(s)"
      user = gets.chomp

    end

    funny_business if @count == 5 and @player.total < 21

    p "Your total is #{@player.total}"

    p "************************"

    # Start dealing cards for dealer
    @dealer.show

      until @dealer.total > 15
        p "*********************"
        @dealer.hit

        if @dealer.total > 21
          p "You win. Dealer loose"
          return
        end

      end
      p "*********************"


      #Keep getting card if player and dealer draw

      if @player.total == @dealer.total
      p "*********************"
        p "You and dealer draw so you have to hit one more card"

        @player.hit

        @count += 1

        if @total > 21
          p "You busted. You loose"
          return
        end

        funny_business if @count == 5 and @total < 21
      end

      if @player.total > @dealer.total
        p "You win. Dealer Loose"

      elsif @player.total < @dealer.total
        p "You loose. Dealer win"
      end
  end

  def funny_bussiness
    p "You win a funny bussiness"
  end

end

Deck.build_cards

Deck.deal_card
game = Game.new
#thanh = Hand.new "Thanh"
# #dealer = Hand.new "Dealer"
#thanh.show
# #dealer.show
# thanh.hit

game.pass_card
