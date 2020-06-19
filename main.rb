# frozen_string_literal: true

require_relative 'deck.rb'
require_relative 'dealer.rb'
require_relative 'player.rb'
require_relative 'bank.rb'
require_relative 'interface.rb'

class Game
  include Interface

  attr_reader :bank, :dealer, :player, :deck

  def initialize
    @bank = nil
    @dealer = nil
    @player = nil
    @deck = nil
    @players_name = ''
  end

  def new_game
    welcome
    @bank = Bank.new
    @dealer = Dealer.new
    @player = Player.new
    start_game
    first_distribution
  end

  private

  def start_game
    @deck = Deck.new
    player_info(@player_name, :cash)
    first_distribution
    @bank.bet
    player_move
  end

  def first_distribution
    @deck.create_deck
    @player.player_cards << @deck.give_card
    @dealer.dealer_cards << @deck.give_card
    @player.player_cards << @deck.give_card
    @dealer.dealer_cards << @deck.give_card
    @player.show_cards
    player_info(@player_name, :scoring)
    puts 'Dealer cards: ** **'
  end

  def menu
    if @bank.cash[:player_cash].zero?
      empty_bank(@player_name)
      finish
    elsif @bank.cash[:dealer_cash].zero?
      empty_bank('Dealer')
      finish
    end
    options = continue_game
    if options == 'Y'
      @player.player_cards.clear
      @dealer.dealer_cards.clear
      start_game
    else
      finish
    end
  end

  def results
    if @player.scoring > 21
      player_info(@player_name, :lost)
      @bank.dealer_win
    elsif @dealer.scoring > 21
      player_info(@player_name, :win)
      @bank.player_win
    elsif @player.scoring > @dealer.scoring
      player_info(@player_name, :win)
      @bank.player_win
    elsif @player.scoring < @dealer.scoring
      player_info(@player_name, :lost)
      @bank.dealer_win
    else
      player_info(@player_name, :equal)
      @bank.draw
    end
    @bank.show_cache
    menu
  end

  def player_move
    loop do
      options = take_card(@player_name)
      if options == 'Y'
        @player.player_cards << @deck.give_card
        @player.show_cards
        player_info(@player_name, :scoring)
        results if @player.scoring > 21
        dealer_move
      elsif options == 'N'
        action_game(:dealer_action)
        dealer_move
      else
        action_game(:error)
        redo
      end
    end
  end

  def dealer_move
    @dealer.show_cards
    dealer_info
    if @dealer.scoring < 17
      @dealer.dealer_cards << @deck.give_card
      @dealer.show_cards
      dealer_info
      results
    else
      action_game(:round)
      results
    end
  end
end
game = Game.new
game.new_game
