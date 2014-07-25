require './lib/board'

describe Board do
	let(:board){ Board.new }
	context 'at initialization' do
		it 'uses a hash for the grid' do
			expect(board.grid.class).to eq Hash
		end

		it 'has 100 key-value pairs' do
			expect(board.grid.length).to eq 100
		end

		it 'has some content in each cell' do
			board.grid.values.each do |cell|
				expect(cell.content).to be_an_instance_of Water
			end
		end
	end

	context 'placing ships' do
		it 'can place a ship' do
			cell           = double :cell
			board          = Board.new(content: cell)
			ship           = double :ship
			locations      = ['A1']
			location       = 'A1'
			at_coordinates = double :coordinates, locations: locations

			expect(at_coordinates.locations).to receive(:each).and_yield(location)
			expect(board.grid[location]).to receive(:content=).with(ship)

			board.place(ship, at_coordinates)
		end
	end

	context 'can display a representation of the grid' do
		it 'displays an empty grid' do
			allow(STDOUT).to receive(:puts)
			water = double :water, class: Water
			board = Board.new(content: water)
			expect(board.render_display).to eq [
                        [" ", " ", " ", " ", " ", " ", " ", " ", " ", " "],
                        [" ", " ", " ", " ", " ", " ", " ", " ", " ", " "],
                        [" ", " ", " ", " ", " ", " ", " ", " ", " ", " "],
                        [" ", " ", " ", " ", " ", " ", " ", " ", " ", " "],
                        [" ", " ", " ", " ", " ", " ", " ", " ", " ", " "],
                        [" ", " ", " ", " ", " ", " ", " ", " ", " ", " "],
                        [" ", " ", " ", " ", " ", " ", " ", " ", " ", " "],
                        [" ", " ", " ", " ", " ", " ", " ", " ", " ", " "],
                        [" ", " ", " ", " ", " ", " ", " ", " ", " ", " "],
                        [" ", " ", " ", " ", " ", " ", " ", " ", " ", " "]
                      ]
		end
	end

	context '.has_ships fuckstuff and fucknuggets' do
		before do
			board.place(PatrolBoat.new, Coordinates.new(['A1', 'A2']))
			board.place(Submarine.new, Coordinates.new(['B1', 'B2', 'B3']))
			board.place(Destroyer.new, Coordinates.new(['C1', 'C2', 'C3', 'C4']))
			board.place(Battleship.new, Coordinates.new(['D1', 'D2', 'D3', 'D4', 'D5']))
			board.place(Carrier.new, Coordinates.new(['E1', 'E2', 'E3', 'E4', 'E5', 'E6']))
		end
		it 'provides an array of the board\'s ships' do
			expect(board.placed_ships.values.all?{ |cell| cell.content.class.superclass == Ship }).to be true
		end
	end

	context '.all_ships_sunk? shitbags' do
		before do
			board.place(PatrolBoat.new, Coordinates.new(['A1', 'A2']))
			board.place(Submarine.new, Coordinates.new(['B1', 'B2', 'B3']))
			board.place(Destroyer.new, Coordinates.new(['C1', 'C2', 'C3', 'C4']))
			board.place(Battleship.new, Coordinates.new(['D1', 'D2', 'D3', 'D4', 'D5']))
			board.place(Carrier.new, Coordinates.new(['E1', 'E2', 'E3', 'E4', 'E5', 'E6']))
		end

		it 'it returns false if none of the ships have been sunk' do
			expect(board.all_ships_sunk?).to be false
		end

	end

end