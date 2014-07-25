require './lib/cell'
require './files'

class Board

	def initialize(content: Water.new)
		@grid = create_new_grid_with(content)
	end

	def grid
		@grid
	end

	def place(ship_type, at_coordinates)
		at_coordinates.locations.each do |location|
			grid[location].content = ship_type
		end
	end

	def render_display
		rows = []
		grid.values.map{|cell| cell.status}.each_slice(10){|row| rows << row}
		rows.each{|row| puts row.inspect}
		rows
	end

	def print_home_grid_symbol(contents)
		case contents

		when Water
			return '~'

		when Ship
			return '♛'

		else
			return ' '
		end
	end

	def print_away_grid_symbol(contents)
		case contents

		when Water
			return 'o'

		when Ship
			return 'x'

		else
			return ' '
		end
	end

	def placed_ships
		grid.select{ |coord, cell| cell.content.class.superclass == Ship }
	end

	def has_ships?
		placed_ships.length == 20
	end

	def all_ships_sunk?
		ships = []
		placed_ships.each_value do |cell|
			ships << cell.content if cell.content.floating?
		end
		ships.empty?
	end

	private

	def create_new_grid_with(content)
		grid = {}
		(1..10).to_a.each{ |row| ('A'..'J').to_a.each{ |column| grid["#{column}#{row}"] = Cell.new(content) }}
		grid
	end

end