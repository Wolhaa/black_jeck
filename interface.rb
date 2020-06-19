# frozen_string_literal: true

module Interface
  def welcome
    puts 'Welcome to Black Jeck!'
    puts 'Enter your name'
    @players_name = gets.chomp.capitalize
  end

  def player_info(_player_name, options)
    case options
    when :cash
      puts "#{@players_name}, in your bank #{@bank.cash[:player_cash]}"
    when :scoring
      puts "#{@players_name}, total points: #{@player.scoring}"
    when :lost
      puts "#{@players_name}, you lost!!"
    when :win
      puts "#{@players_name}, you win!!"
    when :equal
      puts "#{@players_name}, equal points! Draw!"
    end
  end

  def take_card(_player_name)
    puts "Take a card, #{@players_name}? (Enter Y or N)"
    options = gets.chomp.capitalize
  end

  def empty_bank(name)
    puts "#{name}, bank is empty!"
  end

  def dealer_info
    puts "Dealer total points: #{@dealer.scoring}"
  end

  def action_game(action)
    case action
    when :dealer_action
      puts 'Move to dealer'
    when :error
      puts 'Incorrect input'
    when :round
      puts 'Open cards!'
    end
  end

  def continue_game
    puts 'Do you want to continue the game? (Y)'
    options = gets.chomp.capitalize
  end

  def finish
    abort 'The game is over!'
  end
end
