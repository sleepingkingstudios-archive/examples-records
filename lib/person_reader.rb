# lib/person_reader.rb

require 'parsers/comma_parser'
require 'parsers/pipe_parser'
require 'parsers/space_parser'

module PersonReader
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
