require_relative 'entity'

class Player < Entity

	def initialize(window, row, column, height, width, image_file_name='')
		super(window, row, column, height, width, image_file_name)

		@sight_range = 1
	end

	def within_sight(row, column)
		if (@row == row || @row-@sight_range == row || @row+@sight_range == row) &&
			(@column == column || @column-@sight_range == column || @column+@sight_range == column)
			true
		else
			false
		end
	end

	def move_up
		if @row > 0 && @window.tiles[@row-1][@column].walkable
			@row -= 1
		end
		@y = @window.y_coordinate(@row)
	end

	def move_down
		if @row < @window.rows-1 && @window.tiles[@row+1][@column].walkable
			@row += 1
		end
		@y = @window.y_coordinate(@row)
	end

	def move_left
		if @column > 0 && @window.tiles[@row][@column-1].walkable
			@column -= 1
		end
		@x = @window.x_coordinate(@column)
	end

	def move_right
		if @column < @window.columns-1 && @window.tiles[@row][@column+1].walkable
			@column += 1
		end
		@x = @window.x_coordinate(@column)
	end
end