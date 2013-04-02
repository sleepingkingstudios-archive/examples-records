# lib/person.rb

require 'record'

# Data class for storing information about a person.
class Person < Record
  attributes *%w(last_name first_name middle_initial gender date_of_birth
    favorite_color).map(&:intern)
  
  # @return [String] The person's gender in full string format. Can return
  #   "Female", "Male", or "Other".
  def gender
    case
    when @attributes[:gender] =~ /f/i
      "Female"
    when @attributes[:gender] =~ /m/i
      "Male"
    else
      "Other"
    end # case
  end # method gender
end # class Person
