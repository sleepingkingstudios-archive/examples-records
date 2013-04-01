# lib/person.rb

require 'record'

class Person < Record
  attributes *%w(last_name first_name middle_initial gender date_of_birth
    favorite_color).map(&:intern)
end # class Person
