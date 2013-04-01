# spec/parsers/person_parser_spec.rb

require 'spec_helper'

require 'date'
require 'parsers/person_parser'

describe Parsers::PersonParser do
  let :pattern do %r(
    (?<last_name>      [A-Z][a-z]+ ){0}
    (?<first_name>     [A-Z][a-z]+ ){0}
    (?<day>            0?\d{1,2} ){0}
    (?<month>          0?\d{1,2} ){0}
    (?<year>           \d{4} ){0}
    (?<date_of_birth>  \g<year>-\g<month>-\g<day> ){0}
    
    \g<first_name>\s\g<last_name>,\sborn\s\g<date_of_birth>
  )x; end
  let :instance do described_class.new pattern; end
  
  specify { expect(instance).to respond_to(:parse).with(1).arguments }
  
  describe 'with invalid data' do
    specify { expect { instance.parse '' }.not_to raise_error }
    specify { expect(instance.parse '').to be nil }
  end # describe
  
  describe 'with sample data' do
    let :attributes do FactoryGirl.attributes_for :person; end
    let :source do
      str = "#{attributes[:first_name]} #{attributes[:last_name]}" +
        ", born #{DateTime.strptime(attributes[:date_of_birth], "%m/%d/%Y").strftime("%Y-%m-%d")}"
    end # let
    let :person do instance.parse source; end
    
    specify { expect(person).to be_a Person }
    specify { expect(person.first_name).to    be == attributes[:first_name] }
    specify { expect(person.last_name).to     be == attributes[:last_name] }
    specify { expect(person.date_of_birth).to be == attributes[:date_of_birth] }
  end # describe
end # describe
