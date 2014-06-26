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

end