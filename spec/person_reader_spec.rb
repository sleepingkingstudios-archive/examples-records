# spec/person_reader_spec.rb

require 'spec_helper'

require 'person_reader'

describe PersonReader do
  specify { expect(described_class).to respond_to(:read).with(1).arguments }
  
  def self.read_formatted_stream params = {}, &block
    let :keys do
      keys = %w(last_name first_name middle_initial gender favorite_color
        date_of_birth).map(&:intern)
      keys.delete_if { |key| params[:except].include? key } if params.has_key?(:except)
      keys
    end # let
    
    let :count do 20 + rand(30); end
    let :attributes do [*0...count].map { FactoryGirl.attributes_for :person }; end
    let :source do attributes.map { |attrs| yield attrs }.join("\n"); end
    let :records do described_class.read StringIO.new source; end
    
    specify { expect(records.count).to be == count }
    
    specify 'reads attributes' do
      records.each_with_index do |record, index|
        keys.each do |key|
          expect(record.send key).to be == attributes[index][key]
        end # each
      end # each_with_index
    end # specify
  end # class method read_formatted_stream
  
  describe 'with comma-separated records' do
    read_formatted_stream :except => [:middle_initial], &Parsers::FORMATS[:comma]
  end # describe
  
  describe 'with pipe-separated records' do
    before :each do
      attributes.each { |attrs| attrs[:gender] = attrs[:gender][0] }
    end # before each
    
    read_formatted_stream &Parsers::FORMATS[:pipe]
  end # describe

  describe 'with space-separated records' do
    before :each do
      attributes.each { |attrs| attrs[:gender] = attrs[:gender][0] }
    end # before each
    
    read_formatted_stream &Parsers::FORMATS[:pipe]
  end # describe
end # describe
