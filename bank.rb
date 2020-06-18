# frozen_string_literal: true

class Bank
  attr_reader :cash

  def initialize
    @cash = {}
    @cash[:dealer_cash] = 100
    @cash[:player_cash] = 100
  end

  def bet
    @cash[:dealer_cash] -= 10
    @cash[:player_cash] -= 10
  end

  def player_win
    @cash[:player_cash] += 20
  end

  def dealer_win
    @cash[:dealer_cash] += 20
  end

  def draw
    @cash[:dealer_cash] += 10
    @cash[:player_cash] += 10
  end

  def show_cache
    @cash.each do |key, value|
      puts "#{key} - #{value}"
    end
  end
end
