require_relative 'entity'

class Orb < Entity

	def initialize(window, row, column)
		height = 50.0
		width = 50.0
		image_file_name = 'assets/ball.png'

		super(window, row, column, height, width, image_file_name)
	end
end