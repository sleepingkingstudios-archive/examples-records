# lib/parsers/person_parser.rb

require 'parsers'
require 'person'

module Parsers
  class PersonParser
    def initialize pattern
      @pattern = pattern
    end # constructor

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
