require './files'

class Game
	attr_reader :players

	def initialize
		@players = []
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


end