# frozen_string_literal: true

class Player
  attr_reader :player_cards

  def initialize
    @player_cards = []
  end

  def show_cards
    @player_cards.each do |card|
      card.each_key do |key|
        print "#{key} "
      end
    end
  end

  def scoring
    sum = 0
    @player_cards.each do |card|
      card.each_value do |value|
        sum += value
        sum -= 10 if value == 11 && sum > 21
      end
    end
    sum
  end
end
