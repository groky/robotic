module Robot
  class Table

    attr_reader :surface, :rows, :columns

    def initialize(rows=nil, columns=nil)
      @rows    = rows.nil?    ? 5 : rows
      @columns = columns.nil? ? 5 : columns

      @surface = Array.new(self.rows, [*0...self.columns])
    end

    def row_limit_index
      rows - 1
    end

    def column_limit_index
      columns - 1
    end

    def has_point?(x, y)
      #--
      # surface = [
      #  [0, 1, 2, 3, 4 ...],
      #  [0, 1, 2, 3, 4 ...],
      # ...
      # ]
      # x column
      # y row
      surface[y].include? x
    end
  end
end
