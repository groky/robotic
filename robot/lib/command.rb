require_relative 'command_validator'

class Command

  MOVE   = "MOVE"
  PLACE  = "PLACE"
  LEFT   = "LEFT"
  RIGHT  = "RIGHT"
  REPORT = "REPORT"
  QUIT   = "QUIT"

  attr_reader :command, :options

  def initialize
    @options = {}
  end

  def read(source = STDIN)

    @user_input = source.gets.chomp.strip

    if CommandValidator.valid?(user_input)
      format_input
    else
      raise "Please supply a valid input. Valid inputs include:\n" + valid_commands
    end
  end

  private

  attr_reader :user_input

  def format_input
    if user_input =~ /PLACE/
      params = user_input.split(" ")
      @command = params[0]
      @options = build_options(params[1])
    else
      @command = user_input
    end
  end

  def build_options(placement)
    parts = placement.split(",")
    { column: parts[0].to_i, row: parts[1].to_i, direction: parts[2] }
  end

  def valid_commands
<<-MESSAGE
PLACE 1,2,SOUTH
MOVE
LEFT
RIGHT
REPORT
Q or QUIT to quit
MESSAGE
  end
end
