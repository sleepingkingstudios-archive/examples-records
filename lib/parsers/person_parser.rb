# lib/parsers/person_parser.rb

require 'parsers'
require 'person'

module Parsers
  # Processes a string input and returns a Person instance.
  class PersonParser
    # @param [Regexp] pattern The pattern used to parse the string input. Must
    #   have the following named capture groups: :month, :day, :year to
    #   generate date of birth, and optionally uses the :last_name,
    #   :first_name, :middle_initial, :gender, and :favorite_color named groups
    #   to set those attributes as well.
    def initialize pattern
      @pattern = pattern
    end # constructor
    
    # Parses the input string and returns a Person instance whose attributes
    # are determined by processing the input.
    # 
    # @param [String] string The input string to parse.
    # @return [Person] A Person with attributes set by the input string, or nil
    #   if the string does not match the pattern.
    def parse string
      attributes, matches = {}, @pattern.match(string)
      
      return nil if matches.nil?
      
      %w(last_name first_name gender middle_initial favorite_color).
        map(&:intern).each { |key|
          if matches.names.include? key.to_s
            attributes[key] = matches[key] || ""
          else
            attributes[key] = ""
          end # if-else
        } # end each
      attributes[:date_of_birth] = DateTime.new(matches[:year].to_i,
        matches[:month].to_i, matches[:day].to_i).strftime("%m/%d/%Y")
      
      Person.new attributes
    end # method parse
  end # class PersonParser
end # module
