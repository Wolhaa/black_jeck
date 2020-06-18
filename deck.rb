# frozen_string_literal: true

class Deck
  attr_reader :deck

  SUITS = ['♤', '♧', '♡', '♢'].freeze
  VALUES = (2..10).to_a + %w[J Q K A]

  def initialize
    @deck = []
  end

  def create_deck
    VALUES.each do |value|
      SUITS.each do |suit|
        card = {}
        key = value.to_s + suit
        card[key] = if value.is_a? Integer
                      value
                    elsif value != 'A'
                      10
                    else
                      11
                    end
        @deck << card
      end
    end
    @deck.shuffle!
  end

  def give_card
    @deck.shift
  end
end
