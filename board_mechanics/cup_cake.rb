require_relative 'entity'

class CupCake < Entity

	def initialize(window, row, column)
		height = 50.0
		width = 50.0
		image_file_name = 'assets/cup_cake.png'

		super(window, row, column, height, width, image_file_name)
	end
end