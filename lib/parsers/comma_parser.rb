# lib/parsers/comma_parser.rb

require 'parsers/person_parser'

module Parsers
  class CommaParser < PersonParser
    # Processes a string of the form:
    # 
    #   Abercrombie, Neil, Male, Tan, 2/13/1943
    PATTERN = %r(
      (?<last_name>      [A-Z][a-z]+ ){0}
      (?<first_name>     [A-Z][a-z]+ ){0}
      (?<middle_initial> [A-Z] ){0}
      (?<gender>         (M|Fem)ale ){0}
      (?<favorite_color> [A-Z][a-z]* ){0}
      (?<day>            0?\d{1,2} ){0}
      (?<month>          0?\d{1,2} ){0}
      (?<year>           \d{4} ){0}
      (?<date_of_birth>  \g<month>\/\g<day>\/\g<year> ){0}

      \g<last_name>,\s*
      \g<first_name>,\s*
      \g<gender>[a-z]*,\s*
      \g<favorite_color>,\s*
      \g<date_of_birth>
    )x
    
    def initialize
      super PATTERN
    end # constructor
  end # class CommaParser
end # module
