
class ToyRobot
  attr_reader :position, :direction, :board

  DIRECTIONS = [:north, :east, :south, :west]

  def initialize(board)
    raise TypeError, 'Invalid board' if board.nil?

    @board = board
  end

  def place(x, y, direction)
    raise TypeError, 'Invalid coordinates' unless x.is_a? Integer and y.is_a? Integer
    raise TypeError, 'Invalid direction' unless DIRECTIONS.include?(direction)

    if valid_position?(x, y)
      @position = { x: x, y: y }
      @direction = direction
      true
    else
      false
    end

  end

  def move
    position = @position
    movement = nil

    case @direction
    when :north
      movement = { x: 0, y: 1}
    when :east
      movement = { x: 1, y: 0}
    when :south
      movement = { x: 0, y: -1}
    when :west
      movement = { x: -1, y: 0}
    end

    moved = true

    if valid_position?(position[:x] + movement[:x], position[:y] + movement[:y])
      @position = { x: position[:x] + movement[:x], y: position[:y] + movement[:y] }
    else
      moved = false
    end

    moved
  end

  def rotate_left
    index = DIRECTIONS.index(@direction)
    @direction = DIRECTIONS.rotate(-1)[index]
  end

  def rotate_right
    index = DIRECTIONS.index(@direction)
    @direction = DIRECTIONS.rotate()[index]
  end

  private

  def valid_position?(x, y)
    (x >= 0 && x <= self.board.columns && y >= 0 && y <= self.board.rows)
  end

end