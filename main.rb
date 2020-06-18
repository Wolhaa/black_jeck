require_relative 'deck.rb'
require_relative 'dealer.rb'
require_relative 'player.rb'
require_relative 'bank.rb'

class Game


  attr_reader :bank, :dealer, :player, :deck

  def initialize
    @bank = nil
    @dealer = nil
    @player = nil
    @deck = nil
    @players_name = ""
  end

  def start_game
    puts "Welcome to Black Jeck!"
    puts "Enter your name"
    @players_name = gets.chomp.capitalize
    initial
    first_distribution
  end

  private

  def initial
    @bank = Bank.new
    @deck = Deck.new
    @dealer = Dealer.new
    @player = Player.new
    puts "#{@players_name}, in your bank #{@bank.cash[:player_cash]}"
    first_distribution
  end

  def first_distribution
    @deck.create_deck
    @player.player_cards << @deck.give_card
    @dealer.dealer_cards << @deck.give_card
    @player.player_cards << @deck.give_card
    @dealer.dealer_cards << @deck.give_card
    puts "You got two cards"
    #@player.show_cards
    @dealer.show_cards
  end

end
game = Game.new
game.start_game
