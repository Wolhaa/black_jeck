class Deck
  attr_reader :deck

  SUITS = ["♤", "♧", "♡", "♢"]
  VALUES = (2..10).to_a + %w[J Q K A]

  def initialize
    @deck = []
  end


  #protected


  def create_deck
    VALUES.each do |value|
      SUITS.each do |suit|
        card = {}
        key = value.to_s + suit
        if value.is_a? Integer
          card[key] = value
        elsif value != "A"
          card[key] = 10
        else
          card[key] = 11
        end
        @deck << card
      end
    end
    @deck.shuffle!
    puts @deck
  end

   def give_card
      @deck.shift
   end
end

a = Deck.new
a.create_deck
