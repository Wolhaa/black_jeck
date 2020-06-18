# frozen_string_literal: true

class Dealer
  attr_reader :dealer_cards

  def initialize
    @dealer_cards = []
  end

  def show_cards
    @dealer_cards.each do |card|
      card.each_key do |key|
        print "#{key} "
      end
    end
  end

  def scoring
    sum = 0
    @dealer_cards.each do |card|
      card.each_value do |value|
        sum += value
        sum -= 10 if value == 11 && sum > 21
      end
    end
    sum
  end
end
