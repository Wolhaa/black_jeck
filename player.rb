class Player
   attr_reader :player_cards

   def initialize
     @player_cards = []
   end

   def show_cards
     @player_cards.each do |card|
       print "#{card}"
     end
   end
end
