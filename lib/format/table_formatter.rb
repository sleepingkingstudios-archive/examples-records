# lib/format/table_formatter.rb

module Format
  # Processes a collection of records and outputs the records in tabular
  # format.
  class TableFormatter
    # @param [Enumerable] records Expects a set of objects that responds to
    #   each_with_index.
    # @param [String] separator Expects a string. Used to separate column
    #   entries.
    def initialize records, separator = " "
      @records   = records
      @separator = separator
    end # constructor
    
    # @param [Enumerable] records Expects a set of objects that responds to
    #   each_with_index.
    attr_accessor :records
    
    # @param [String] separator Expects a string. Used to separate column
    #   entries.
    attr_accessor :separator
    
    # Processes the current collection of records using the column definitions
    # provided, and returns the resulting values in tabular form.
    # 
    # @param [Symbol, Proc] *columns Expects one or more column definitions. If
    #   the column is a symbol, sends the symbol to each record to determine
    #   the value for that cell. If the column is a Proc, calls the Proc with
    #   the record as a parameter.
    # @return [String] The result in tabular form.
    def format *columns
      values, widths = [], []
      @records.each_with_index do |record, index|
        values[index] = []

        columns.each_with_index do |column, column_index|
          values[index][column_index] = column.respond_to?(:call) ?
            column.call(record) :
            record.send(column.intern)

          widths[column_index] = values[index][column_index].length if
            values[index][column_index].length > (widths[column_index] || 0)
        end # each
      end # each

      output = ""
      values.each do |line|
        line.each_with_index do |value, column_index|
          output << value << " " * (widths[column_index] - value.length)
          output << @separator unless column_index == line.count - 1
        end # each
        output << "\n"
      end # each

      output
    end # method format
  end # class
end # module
