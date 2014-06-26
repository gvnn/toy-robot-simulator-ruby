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

end