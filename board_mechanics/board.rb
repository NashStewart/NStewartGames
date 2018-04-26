require 'gosu'
require_relative 'player'
require_relative 'orb'


class Board < Gosu::Window

	attr_reader :width, :height, :columns, :rows, :tiles

	def initialize
		@width = 800
		@height = 600

		@columns = 16
		@rows = 12

		super(@width, @height, false)

		@tiles = []
		File.open('board01.txt').each do |line|
			@tiles << line.gsub("\n", '').split(',')
		end

		@player = Player.new(self, 0, 1, 50, 50, 'assets/erza.png')
		@orb = Orb.new(self, -1, -1)
	end

	# LOOP
	def update
		if @player.x == @orb.x && @player.y == @orb.y
			puts "Player wins!"
			close
		end
	end

	def button_down(id)
		close if id == Gosu::KbEscape

		@player.move_up if id == Gosu::KbUp
		@player.move_down if id == Gosu::KbDown
		@player.move_left if id == Gosu::KbLeft
		@player.move_right if id == Gosu::KbRight
	end

	def draw
		#draw_grid
		draw_tiles
		@player.draw
		@orb.draw
	end

	# GRID
	def x_coordinate(column)
		x_index = (@width / (@columns)) * (column)
	end

	def y_coordinate(row)
		y_index = (@height / (@rows)) * (row)
	end

	def draw_grid
		color = Gosu::Color.rgba(255,255,255,100)

		for i in 1..@rows-1 do
			draw_line(0, y_coordinate(i), color, @width, y_coordinate(i), color)
		end

		for i in 1..@columns-1 do
			draw_line(x_coordinate(i), 0, color, x_coordinate(i), @height, color)
		end
	end

	# TILES
	def draw_tiles
		color = Gosu::Color.rgba(100,100,100,255)

		for i in 0..@tiles.length-1 do
			temp = ''
			for j in 0..@tiles[0].length-1 do
				
				if @tiles[i][j] == '0'
					#TODO draw floor
				elsif @tiles[i][j] == '1'
					draw_rect(x_coordinate(j), y_coordinate(i), @width/(@columns), @height/(@rows), color)
				elsif @tiles[i][j] == '2'
					@orb.move(i, j)
				end
			end
		end
	end
end