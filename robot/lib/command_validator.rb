class CommandValidator

  MATCHER = /^(PLACE\s\d,\d,(NORTH|EAST|SOUTH|WEST)|MOVE|LEFT|RIGHT|REPORT)$/

  def self.valid?(input)
    !(input =~ MATCHER).nil?
  end

end
