require 'gosu'
require_relative 'player'
require_relative 'cup_cake'
require_relative 'key'
require_relative 'door'

class Board < Gosu::Window

	attr_reader :width, :height, :columns, :rows, :tiles

	def initialize(board_name)
		@width = 800
		@height = 600

		@columns = 16
		@rows = 12

		super(@width, @height, false)

		@board = []
		File.open(board_name + '.txt').each do |line|
			@board << line.gsub("\n", '').split(',')
		end

		@tiles =Array.new(@board.size){Array.new(@board[0].size)}
		generate_tiles

		@all_keys_obtained = false
	end

	# LOOP
	def update
		# KEYS
		if @player.x == @key_one.x && @player.y == @key_one.y && @key_one.exists
			@key_one.get
			@key_two.exists = true
			@door_one.walkable = true
		end

		if @player.x == @key_two.x && @player.y == @key_two.y && @key_two.exists
			@key_two.get
			@key_three.exists = true
			@door_two.walkable = true
		end

		if @player.x == @key_three.x && @player.y == @key_three.y && @key_three.exists
			@key_three.get
			@all_keys_obtained = true
			@door_three.walkable = true
		end

		# DOORS
		if @player.x == @door_one.x && @player.y == @door_one.y
			@door_one.open
		end

		if @player.x == @door_two.x && @player.y == @door_two.y
			@door_two.open
		end

		if @player.x == @door_three.x && @player.y == @door_three.y
			@door_three.open
		end

		# CUPCAKE
		if @player.x == @cup_cake.x && @player.y == @cup_cake.y && @all_keys_obtained
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
		draw_environment

		draw_objects

		@player.draw
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
	def generate_tiles
		color = Gosu::Color.rgba(25,25,25,255)

		for i in 0..@board.length-1 do
			for j in 0..@board[0].length-1 do

				case @board[i][j]
				when ' '
					@tiles[i][j] = Entity.new(self, i, j, 50 , 50, 'assets/brick_texture.png')
				when '1'
					@tiles[i][j] = Entity.new(self, i, j, 50 , 50, 'assets/rock_texture.png')
					@tiles[i][j].walkable = false
				when 'V'
					@tiles[i][j] = Entity.new(self, i, j, 50 , 50, 'assets/brick_texture.png')
					@cup_cake = CupCake.new(self, i, j)
				when 'p'
					@tiles[i][j] = Entity.new(self, i, j, 50 , 50, 'assets/brick_texture.png')
					@player = Player.new(self, i, j, 50, 50, 'assets/erza.png')
				when 'a'
					@tiles[i][j] = Entity.new(self, i, j, 50 , 50, 'assets/brick_texture.png')
					@key_one = Key.new(self, i, j, 0)
					@key_one.exists = true
				when 'b'
					@tiles[i][j] = Entity.new(self, i, j, 50 , 50, 'assets/brick_texture.png')
					@key_two = Key.new(self, i, j, 2)
				when 'c'
					@tiles[i][j] = Entity.new(self, i, j, 50 , 50, 'assets/brick_texture.png')
					@key_three = Key.new(self, i, j, 1)
				when 'A'
					@door_one = Door.new(self, i, j, 0)
					@tiles[i][j] = @door_one
				when 'B'
					@door_two = Door.new(self, i, j, 2)
					@tiles[i][j] = @door_two
				when 'C'
					@door_three = Door.new(self, i, j, 1)
					@tiles[i][j] = @door_three
				else
					#Entity.new(self, i, j, 50 , 50, 'assets/brick_texture.png').draw
					puts i
					puts j
					draw_rect(x_coordinate(j), y_coordinate(i), @width/(@columns), @height/(@rows), color)
				end
			end
		end
	end

	def draw_environment
		@tiles.each do |row|
			row.each do |tile|
				if @player.within_sight(tile.row, tile.column)
					tile.draw
				end
			end
		end
	end	

	def draw_objects
		objects = []
		objects << @cup_cake

		objects << @key_one
		objects << @key_two
		objects << @key_three

		objects << @door_one
		objects << @door_two
		objects << @door_three

		objects.each do |object|
			if @player.within_sight(object.row, object.column)
				object.draw
			end
		end
	end
end