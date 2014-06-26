require_relative 'board'
require_relative 'toy_robot'

class Simulator

  def initialize
    @board = Board.new 4, 4
    @robot = ToyRobot.new @board
  end

  def execute(command)
    begin
      puts @robot.eval(command)
    rescue Exception => e
      puts e.message
    end
  end

end