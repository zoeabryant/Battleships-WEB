require './lib/game'
require './lib/player'

describe Game do
	let(:board) { Board.new}
	let(:player1) { Player.new(name: "PlayerOne", board: board)}
	let(:player2) { Player.new(name: "PlayerTwo", board: board)}
	let(:game) { Game.new}

	xit 'is initialized with two players' do
		game = Game.new(player1: :player1, player2: :player2)
		expect(game.player1).to eq :player1
		expect(game.player2).to eq :player2
	end

	context ".current_player" do
		it "should provide the current player" do
			name = "PlayerOne"
			game.add player1

			expect(game.current_player(name).name).to eq player1.name
		end
	end

	context ".opponent_player" do
		it "should provide the opponent player" do
			name = "PlayerOne"
			game.add player1
			game.add player2

			expect(game.opponent_player(name).name).to eq player2.name
		end
	end

end