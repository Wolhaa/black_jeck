class Dealer
  attr_reader :dealer_cards

  def initialize
    @dealer_cards = []
  end

  def show_cards
    sum = 0
    @dealer_cards.each do |card|
      card.each do |key, value|
        sum += value
        print "#{key} "
      end
    end
    puts "Total points: #{sum}"
  end
end
