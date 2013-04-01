# spec/support/factories.rb

require 'date'

FactoryGirl.define do
  sequence :person_name do
    letters, vowels = [*?a..?z], %w(a e i o u)
    consonants = letters.delete_if { |char| vowels.include? char }
    
    [].tap { |ary|
      (4 + rand(6)).times { |index|
        ary << ((0 == index & 1) ?
          consonants[rand(21)] :
          vowels[rand(5)])
      } # end times
    }.join('').capitalize
  end # sequence
  
  factory :person do
    sequence :first_name do generate :person_name; end
    sequence :last_name  do generate :person_name; end
    
    middle_initial do [*?A..?Z][rand(26) % 26]; end
    gender do rand(2) == 1 ? "Female" : "Male"; end
    favorite_color do %w(Turquoise Magenta Octarine).sample; end
    
    date_of_birth do
      Date.ordinal(1901 + rand(100), 1 + rand(365)).strftime "%m/%d/%Y"
    end # date of birth
  end # factory
end # define
