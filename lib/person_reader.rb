# lib/person_reader.rb

require 'parsers/comma_parser'
require 'parsers/pipe_parser'
require 'parsers/space_parser'

# Helper class for processing an IO stream, where each line in the stream is a
# serialized Person.
module PersonReader
  # Checks the first line of the stream to determine which parser to use, then
  # loops through each line and processes into a Person object. Lines not
  # matching the determined parser format are ignored.
  # 
  # @param [IO] io Expects an IO stream, where each line is a serialized Person
  #   in a format recognized by one of the parsers. Additionally, all lines
  #   must have the same format: comma-, pipe- or space-formatted.
  # @return [Array] An array of Person objects.
  def self.read io
    line = io.gets
    parser = case
    when line.include?(',')
      Parsers::CommaParser.new
    when line.include?('|')
      Parsers::PipeParser.new
    else
      Parsers::SpaceParser.new
    end # case
    io.pos = 0
    
    records = io.each_line.map { |line|
      parser.parse(line)
    }.compact
    
    records
  end # method read
end # module
