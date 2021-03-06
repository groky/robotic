require_relative 'table'
require_relative 'lib/command'

module Robot
  class Robot

    NORTH = "NORTH"
    WEST  = "WEST"
    SOUTH = "SOUTH"
    EAST  = "EAST"

    STEP = 1
    START_POSITION = 0

    attr_reader :alive, :table, :command, :source, :facing

    def initialize(table=Table.new, command = Command.new)
      @alive    = true
      @source   = source
      @table    = table
      @command  = command
      @position_x = 0
      @position_y = 0
    end

    def run!
      welcome_message

      while(alive)
        begin
          command.read
          invoke
        rescue Exception => e
          e.message
        end
      end

    end

    def location
      [position_x, position_y]
    end

    def stop!
      @alive = false
    end

    private

    attr_reader :position_x, :position_y

    def invoke
      case command.command
      when Command::QUIT, /Q/
        stop!
      when Command::PLACE
        options = command.options
        place(options[:column], options[:row], options[:direction])
      end
    end


    def place(x, y, facing)
      if table.surface.has_point?(x, y)
        @facing     = facing
        @position_x = x
        @position_y = y
      else
        raise "Don't place me here. I will fall!"
      end
    end

    def move
      if can_move?
        @position_x += STEP if facing_east?
        @position_x -= STEP if facing_west?
        @position_y += STEP if facing_north?
        @position_y -= STEP if facing_south?
      else
        raise "I'm going to fall off the edge!"
      end
    end

    def left
      @facing = case facing
      when NORTH
        WEST
      when SOUTH
        EAST
      when EAST
        NORTH
      when WEST
        SOUTH
      end
    end

    def right
      @facing = case facing
      when NORTH
        EAST
      when SOUTH
        WEST
      when EAST
        SOUTH
      when WEST
        NORTH
      end
    end

    def report
      Reporter.report(x, y, facing)
    end

    def can_move?
      case facing
      when NORTH
        can_move_north?
      when SOUTH
        can_move_south?
      when EAST
        can_move_east?
      when WEST
        can_move_west?
      end
    end

    def can_move_north?
      table.row_limit_index >= position_y + STEP
    end

    def can_move_south?
      position_y - STEP >= START_POSITION
    end

    def can_move_east?
      table.column_limit_index >= position_x + STEP
    end

    def can_move_west?
      position_x - STEP >= START_POSITION
    end

    def facing_north?
      facing == NORTH
    end

    def facing_south?
      facing == SOUTH
    end

    def facing_east?
      facing == EAST
    end

    def facing_west?
      facing == WEST
    end

    def welcome_message
  <<-MESSAGE
  Welcome to your personal robot.
  To start, please place me some with: 'PLACE 1,2,EAST'
  Then move me with: MOVE, TURN, LEFT or RIGHT.
  To find out where I am: REPORT
  MESSAGE
    end

  end
end
