require 'Gosu'

class Entity

	attr_accessor :x, :y, :width, :height, :image_file_name, :walkable, :row, :column

	def initialize(window, row, column, height, width, image_file_name='')
		@window = window
		
		@column = column
		@row = row

		@x = @window.x_coordinate(column)
		@y = @window.y_coordinate(row)

		@width = width
		@height = height

		@scale_x = @window.width / (@window.columns) / (@width)
		@scale_y = @window.height / (@window.rows) / (@height)
		
		@image_file_name = image_file_name

		@image = Gosu::Image.new(@image_file_name, rect: [0, 0, @width, @height])

		@walkable = true
	end

	def move(row, column)
		@column = column
		@row = row

		@x = @window.x_coordinate(column)
		@y = @window.y_coordinate(row)
	end

	def draw
		@image.draw(@x, @y, 0, @scale_x, @scale_y)
	end
end