require_relative 'entity'

class Door < Entity

	attr_accessor :exists

	def initialize(window, row, column, door_number)
		height = 50.0
		width = 50.0

		case door_number
		when 0
			image_file_name = 'assets/blue_door.png'
		when 1
			image_file_name = 'assets/red_door.png'
		when 2
			image_file_name = 'assets/purple_door.png'
		end

		super(window, row, column, height, width, image_file_name)

		@exists = true
		@walkable = false
	end

	def open
		@walkable = true
		@image = Gosu::Image.new('assets/open_door.png', rect: [0, 0, @width, @height])
	end

	def draw
		if @exists
			super
		end
	end
end