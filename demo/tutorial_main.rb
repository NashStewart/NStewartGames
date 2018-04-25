require 'gosu'

class GameWindow < Gosu::Window

	def initialize(width, height, fullscreen)
		super(width, height, fullscreen)

		@sprite = Gosu::Image.new('box.png', false)
		@scale = 0.1
		@scale_x = @scale
		@scale_y = @scale
		@x = 800 / 2 - (@sprite.width / 2) * @scale_x
		@y = 600 / 2 - (@sprite.height / 2) * @scale_y

		@total_time = 0
	end

	def update
		@total_time += 16

		@y = @y + @total_time * 0.001

		if @y >= (600 - @sprite.height * @scale)
			@y = 600 / 2 - (@sprite.height / 2) * @scale_y
			@total_time = 0
		end
	end

	def draw
		@sprite.draw(@x, @y, 0, @scale_x, @scale_y)
	end
end

game_window = GameWindow.new(800, 600, false)
game_window.show

