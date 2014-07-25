require './lib/cell'

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

	def print_grid_symbol(contents)
		case contents

		when Water
			return '~'

		when Ship
			return '♛'

		else
			return ' '
		end
	end

	private

	def create_new_grid_with(content)
		grid = {}
		(1..10).to_a.each{ |row| ('A'..'J').to_a.each{ |column| grid["#{column}#{row}"] = Cell.new(content) }}
		grid
	end

end