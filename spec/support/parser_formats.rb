# spec/support/parser_formats.rb

require 'parsers'

module Parsers
  FORMATS = {
    :comma => lambda { |attributes|
      "#{attributes[:last_name]}" +
        ", #{attributes[:first_name]}" +
        ", #{attributes[:gender]}" +
        ", #{attributes[:favorite_color]}" +
        ", #{attributes[:date_of_birth]}"
    }, # end comma format
    :pipe => lambda { |attributes|
      "#{attributes[:last_name]}" +
        " | #{attributes[:first_name]}" +
        " | #{attributes[:middle_initial]}" +
        " | #{attributes[:gender]}" +
        " | #{attributes[:favorite_color]}" +
        " | #{attributes[:date_of_birth].gsub('/', '-')}"
    }, # end pipe format
    :space => lambda { |attributes|
      "#{attributes[:last_name]}" +
        " #{attributes[:first_name]}" +
        " #{attributes[:middle_initial]}" +
        " #{attributes[:gender][0]}" +
        " #{attributes[:date_of_birth].gsub('/','-')}" +
        " #{attributes[:favorite_color]}"
    }, # end space format
  } # end hash FORMATS
end # module