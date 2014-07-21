require './lib/cell'

class Board

	def initialize(content: :water)
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

	private
	
	def create_new_grid_with(content)
		grid = {}
		('A'..'J').to_a.each{ |column| (1..10).to_a.each{ |row| grid["#{column}#{row}"] = Cell.new(content) }}
		grid
	end

end