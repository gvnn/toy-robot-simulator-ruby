require 'spec_helper'

describe ToyRobot do

  before(:each) do
    @board = Board.new 5, 5
    @robot = ToyRobot.new @board
  end

  it 'is placed correctly' do
    expect(@robot.place(0, 1, :north)).to eq(true)
    expect(@robot.place(2, 2, :south)).to eq(true)
    expect(@robot.place(6, 6, :west)).to eq(false)
    expect(@robot.place(-1, 5, :east)).to eq(false)
  end

  it 'should raise exceptions' do
    expect { @robot.place(nil, nil, :east) }.to raise_error(TypeError)
    expect { @robot.place(1, 'abc', nil) }.to raise_error(TypeError)
    expect { @robot.place(1, 0, :northeast) }.to raise_error(TypeError)
  end

  it 'move on the board' do
    @robot.place(0, 0, :north)

    expect(@robot.move).to eq(true)
    expect(@robot.position[:x]).to eq(0)
    expect(@robot.position[:y]).to eq(1)
    expect(@robot.direction).to eq(:north)

    @robot.place(1, 2, :east)
    @robot.move
    @robot.move
    @robot.rotate_left
    @robot.move

    expect(@robot.position[:x]).to eq(3)
    expect(@robot.position[:y]).to eq(3)
    expect(@robot.direction).to eq(:north)

  end

  it 'should rotate on its right' do
    @robot.place(0, 0, :north)
    @robot.rotate_right
    expect(@robot.direction).to eq(:east)
    @robot.rotate_right
    expect(@robot.direction).to eq(:south)
    @robot.rotate_right
    expect(@robot.direction).to eq(:west)
    @robot.rotate_right
    expect(@robot.direction).to eq(:north)
    @robot.rotate_right
    expect(@robot.direction).to eq(:east)
  end

  it 'should rotate on its left' do
    @robot.place(0, 0, :north)
    @robot.rotate_left
    expect(@robot.direction).to eq(:west)
    @robot.rotate_left
    expect(@robot.direction).to eq(:south)
    @robot.rotate_left
    expect(@robot.direction).to eq(:east)
    @robot.rotate_left
    expect(@robot.direction).to eq(:north)
    @robot.rotate_left
    expect(@robot.direction).to eq(:west)
  end

  it 'shouldn\'t exit the board' do
    @robot.place(1, 4, :north)
    expect(@robot.move).to eq(true)
    expect(@robot.move).to eq(false)
  end

  it 'should report its position' do
    @robot.place(5, 5, :east)
    expect(@robot.report).to eq("5,5,EAST")
    @robot.move #this is going outside. Command is ignored and the report is the same as before
    expect(@robot.report).to eq("5,5,EAST")
    @robot.rotate_right
    @robot.move
    expect(@robot.report).to eq("5,4,SOUTH")
  end

  it 'should eval commands' do
    @robot.eval("PLACE 0,0,NORTH")
    expect(@robot.report).to eq("0,0,NORTH")

    @robot.eval("MOVE")
    @robot.eval("RIGHT")
    @robot.eval("MOVE")

    expect(@robot.report).to eq("1,1,EAST")

    # if it goes out of the board it ignores the command
    for i in 0..10
      @robot.eval("MOVE");
    end
    expect(@robot.report).to eq("5,1,EAST")

    # rotate on itself
    for i in 0..3
      @robot.eval("LEFT");
    end
    expect(@robot.report).to eq("5,1,EAST")

  end

  it 'should ignore invalid commands' do
    expect { @robot.eval("PLACE12NORTH") }.to raise_error(ArgumentError)
    expect { @robot.eval("LEFFT") }.to raise_error(ArgumentError)
    expect { @robot.eval("RIGHTT") }.to raise_error(ArgumentError)
  end

end