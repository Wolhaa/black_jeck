# frozen_string_literal: true

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
    @players_name = ''
  end

  def new_game
    puts 'Welcome to Black Jeck!'
    puts 'Enter your name'
    @players_name = gets.chomp.capitalize
    @bank = Bank.new
    @dealer = Dealer.new
    @player = Player.new
    start_game
    first_distribution
  end

  private

  def start_game
    @deck = Deck.new
    puts "#{@players_name}, in your bank #{@bank.cash[:player_cash]}"
    first_distribution
    @bank.bet
    puts 'Ставки сделаны'
    player_move
  end

  def first_distribution
    @deck.create_deck
    @player.player_cards << @deck.give_card
    @dealer.dealer_cards << @deck.give_card
    @player.player_cards << @deck.give_card
    @dealer.dealer_cards << @deck.give_card
    puts 'You got two cards'
    @player.show_cards
    puts "Total points: #{@player.scoring}"
    puts 'Dealer cards: ** **'
  end

  def menu
    if @bank.cash[:player_cash].zero?
      puts 'Your bank is empty!'
      abort 'The game is over!'
    elsif @bank.cash[:dealer_cash].zero?
      puts 'Dealer bank is empty!'
      abort 'The game is over!'
    end
    puts 'Do you want to continue the game? (Y)'
    options = gets.chomp.capitalize
    if options == 'Y'
      @player.player_cards.clear
      @dealer.dealer_cards.clear
      start_game
    else
      abort 'The game is over!'
    end
  end

  def results
    if @player.scoring > 21
      puts "#{@players_name}, you lost!!"
      @bank.dealer_win
    elsif @dealer.scoring > 21
      puts "#{@players_name}, you win!!"
      @bank.player_win
    elsif @player.scoring > @dealer.scoring
      puts "#{@players_name}, you win!!"
      @bank.player_win
    elsif @player.scoring < @dealer.scoring
      puts "#{@players_name}, you lost!!"
      @bank.dealer_win
    else
      puts 'Equal points!'
      @bank.draw
    end
    @bank.show_cache
    menu
  end

  def player_move
    loop do
      puts "Take a card, #{@players_name}? (Enter Y or N)"
      options = gets.chomp.capitalize
      if options == 'Y'
        @player.player_cards << @deck.give_card
        @player.show_cards
        puts "#{@players_name} total points: #{@player.scoring}"
        results if @player.scoring > 21
        dealer_move
      elsif options == 'N'
        puts 'Move to dealer'
        dealer_move
      else
        puts 'Incorrect input'
        redo
      end
    end
  end

  def dealer_move
    @dealer.show_cards
    puts "Dealer total points: #{@dealer.scoring}"
    if @dealer.scoring < 17
      puts ' Dealer will take a card'
      @dealer.dealer_cards << @deck.give_card
      @dealer.show_cards
      puts "Dealer total points: #{@dealer.scoring}"
      results
    else
      puts 'Open cards!'
      results
    end
  end
end
game = Game.new
game.new_game
