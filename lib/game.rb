require './files'

class Game

	attr_reader :players

	def initialize
		@players = []
	end

	def add player
		@players << player
	end

	def start?
		@players.count == 2
	end
end