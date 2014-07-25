require './files'

class Game
	attr_reader :players

	def initialize
		@players = []
		@counter = 1
	end

	def add player
		@players << player unless start?
	end

	def start?
		@players.count == 2
	end

	def current_player(name)
		@players.select {|player| player.name == name}.first
	end

	def opponent_player(name)
		@players.reject {|player| player.name == name}.first
	end

	def countup
		@counter += 1
	end

	def my_turn?(player)
		return true if player == @players.first && @counter.odd?
		return true if player == @players.last && @counter.even?
		false
	end

	def there_a_victor?
		@players.any?{ |player| player.board.all_ships_sunk? }
	end

	def get_victor
		@players.reject{ |player| player.board.all_ships_sunk? }.first
	end



end