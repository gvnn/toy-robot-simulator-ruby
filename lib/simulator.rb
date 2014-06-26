require_relative 'board'
require_relative 'toy_robot'

class Simulator

  def initialize
    @board = Board.new 4, 4
    @robot = ToyRobot.new @board
  end

  COMMANDS = [:place, :move, :left, :right, :report]

end