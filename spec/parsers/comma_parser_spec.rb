# spec/parsers/comma_parser_spec.rb

require 'spec_helper'

require 'date'
require 'parsers/comma_parser'

describe Parsers::CommaParser do
  let :instance do described_class.new; end
  
  specify { expect(instance).to respond_to(:parse).with(1).arguments }
  
  describe 'with sample data' do
    let :attributes do FactoryGirl.attributes_for :person; end
    let :source do Parsers::FORMATS[:comma].call attributes; end
    let :person do instance.parse source; end
    
    specify { expect(person).to be_a Person }
    specify { expect(person.last_name).to      be == attributes[:last_name] }
    specify { expect(person.first_name).to     be == attributes[:first_name] }
    specify { expect(person.gender).to         be == attributes[:gender] }
    specify { expect(person.favorite_color).to be == attributes[:favorite_color] }
    specify { expect(person.date_of_birth).to  be == attributes[:date_of_birth] }
  end # describe
end # describe
