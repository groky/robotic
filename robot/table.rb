module Robot
  class Table

    attr_reader :board, :rows, :columns

    def initialize(rows=nil, columns=nil)
      @rows    = rows.nil?    ? 5 : rows
      @columns = columns.nil? ? 5 : columns

      @board = Array.new(self.rows, [*0...self.columns])
    end

    def row_limit_index
      rows - 1
    end

    def column_limit_index
      columns - 1
    end
  end
end