require 'gosu'
require_relative 'board'
require_relative 'player'

class Game

	def initialize
		board = Board.new('boards/board02')
		board.show
	end
end

Game.new