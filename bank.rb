class Bank
  attr_reader :cash

  def initialize
    @cash = {}
    @cash[:dealer_cash] = 100
    @cash[:player_cash] = 100
    @cash[:game_cash] = 0
  end

  def bet
    @cash[:dealer_cash] -= 10
    @cash[:player_cash] -= 10
    @cash[:game_cash] += 20
  end

  def player_win
    @cash[:player_cash] += @cache[:game_cash]
  end

  def dealer_win
    @cash[:dealer_cash]+= @cache[:game_cash]
  end

  def draw
    @cash[:game_cash] = 0
    @cash[:dealer_cash] += 10
    @cash[:player_cash] += 10
  end

  def show_cache
    @cash.each do |key, value|
      puts "#{key} - #{value}"
    end
end
