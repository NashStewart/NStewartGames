require_relative 'entity'

class Player < Entity

	def initialize(window, row, column, height, width, image_file_name='')
		super(window, row, column, height, width, image_file_name)
	end

	def move_up
		if @row > 0 && @window.tiles[@row-1][@column] != '1'
			@row -= 1
		end
		@y = @window.y_coordinate(@row)
	end

	def move_down
		if @row < @window.rows-1 && @window.tiles[@row+1][@column] != '1'
			@row += 1
		end
		@y = @window.y_coordinate(@row)
	end

	def move_left
		if @column > 0 && @window.tiles[@row][@column-1] != '1'
			@column -= 1
		end
		@x = @window.x_coordinate(@column)
	end

	def move_right
		if @column < @window.columns-1 && @window.tiles[@row][@column+1] != '1'
			@column += 1
		end
		@x = @window.x_coordinate(@column)
	end
end