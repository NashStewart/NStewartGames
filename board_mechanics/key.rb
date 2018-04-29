require_relative 'entity'

class Key < Entity

	attr_accessor :exists, :obtained

	def initialize(window, row, column, key_number)
		height = 50.0
		width = 50.0
		
		case key_number
		when 0
			image_file_name = 'assets/blue_key.png'
		when 1
			image_file_name = 'assets/red_key.png'
		when 2
			image_file_name = 'assets/purple_key.png'
		end

		super(window, row, column, height, width, image_file_name)

		@exists = false
		@obtained = false
	end

	def get
		@exists = false
		@obtained = true
	end

	def draw
		if @exists
			super
		end
	end
end