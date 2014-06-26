require_relative 'lib/simulator'

simulator = Simulator.new
puts "# Toy Robot Simulator"
puts "# Enter a command, Valid commands are:"
puts "# \'PLACE X,Y,NORTH|SOUTH|EAST|WEST\', MOVE, LEFT, RIGHT, REPORT or EXIT"

command = STDIN.gets

while command
  command.strip!
  if command == "EXIT"
    puts "# Bye"
    exit
  else
    output = simulator.execute(command)
    puts output if output
    command = STDIN.gets
  end
end