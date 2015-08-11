require_relative 'robot'
require_relative 'table'

module Robot::Runner
  
  MATCHER = /^(PLACE\s\d,\d,(NORTH|EAST|SOUTH|WEST)|MOVE|LEFT|RIGHT|REPORT)$/

  def run!

    welcome_message

    while true do

      input = gets.chomp

      Kernel.exit(false) if input =~ /Q/

      handle_input input

    end
  end

  def valid?(input)
    !(input =~ MATCHER).nil?
  end

  def robot
    @robot ||= Robot::Robot.new(table)
  end

  def table
    @table ||= Robot::Table.new(columns,rows)
  end

  def handle_input(input)

    if valid?(input)
      params = {}
      command = nil

      # handle the params for the PLACE command
      unless (input =~ /PLACE/).nil?
        params = placement_params(input)
        command = params[:command]
      else
        command = input
      end
      
      # fire the command off to the robot
      puts activate(command.to_s.downcase, params)

    else
      puts "Please supply a valid input. Valid inputs include:\n" + valid_commands
    end
  end

  def valid_commands
   "PLACE 1,2,SOUTH \n
MOVE\n
LEFT\n
RIGHT\n
REPORT\n
Q or QUIT to quit"
  end

  def welcome_message
    "Welcome to your personal robot. \n
To start, please place me some with: 'PLACE 1,2,EAST'\n
Then move me with: MOVE, TURN, LEFT or RIGHT.\n
To find out where I am: REPORT\n"
  end

  def activate(command, params=nil)
    if params.empty? 
      robot.send(command)
    else
      robot.send(command, params[:column], params[:row], params[:direction])
    end
  end

  def placement_params(input)
    params = input.split(" ")
    values  = params[1].split(",")

    {
      command:   params[0], 
      column:    values[0].to_i,
      row:       values[1].to_i,
      direction: values[2]
    }
  end

  def set_columns(val)
    @columns = val
  end

  def columns
    @columns
  end

  def set_rows(val)
    @rows = val
  end

  def rows
    @rows
  end

end

include Robot::Runner
run!