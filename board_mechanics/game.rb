require 'gosu'
require_relative 'board'
require_relative 'player'

class Game

	def initialize
		board = Board.new
		board.show
	end
end

Game.new