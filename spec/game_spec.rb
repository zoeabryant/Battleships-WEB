require './lib/game'

describe Game do
	it 'is initialized with two players' do
		game = Game.new(player1: :player1, player2: :player2)
		expect(game.player1).to eq :player1
		expect(game.player2).to eq :player2
	end
end