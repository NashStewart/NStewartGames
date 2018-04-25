require 'Gosu'

class Player

	attr_accessor :x, :y

	def initialize(window)
		@window = window

		@width = 50.0
		@height = 50.0

		@scale_x = @window.width / (@window.columns) / (@width)
		@scale_y = @window.height / (@window.rows) / (@height)

		@column = 0
		@row = 0
		@x = 0
		@y = 0

		@speed = 1
		@image = Gosu::Image.new('erza.png', rect: [0, 0, @width, @height])
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

	def draw
		@image.draw(@x, @y, 0, @scale_x, @scale_y)
	end
end