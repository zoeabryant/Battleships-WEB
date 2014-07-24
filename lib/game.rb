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
		@players.count == 1
	end
end