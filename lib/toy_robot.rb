
class ToyRobot
  attr_reader :position, :direction, :board

  DIRECTIONS = [:north, :east, :south, :west]
  COMMANDS = [:place, :move, :left, :right, :report]

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
    return false if @position.nil?

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
    return false if @direction.nil?

    index = DIRECTIONS.index(@direction)
    @direction = DIRECTIONS.rotate(-1)[index]
    true
  end

  def rotate_right
    return false if @direction.nil?

    index = DIRECTIONS.index(@direction)
    @direction = DIRECTIONS.rotate()[index]
    true
  end

  def report
    return "Not on board" if @position.nil? or @direction.nil?

    "#{@position[:x]},#{@position[:y]},#{@direction.to_s.upcase}"
  end

  def eval(input)
    return if input.strip.empty?

    args = input.split(/\s+/)
    command = args.first.to_s.downcase.to_sym
    arguments = args.last

    raise ArgumentError, 'Invalid command' unless COMMANDS.include?(command)

    case command
    when :place
      raise ArgumentError, 'Invalid command' if arguments.nil?

      tokens = arguments.split(/,/)

      raise ArgumentError, 'Invalid command' unless tokens.count > 2

      x = tokens[0].to_i
      y = tokens[1].to_i
      direction = tokens[2].downcase.to_sym

      place(x, y, direction)
    when :move
      move
    when :left
      rotate_left
    when :right
      rotate_right
    when :report
      report
    else
      raise ArgumentError, 'Invalid command'
    end

  end

  private

  def valid_position?(x, y)
    (x >= 0 && x <= self.board.columns && y >= 0 && y <= self.board.rows)
  end

end