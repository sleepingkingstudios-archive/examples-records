# spec/record_spec.rb

require 'spec_helper'

require 'record'

describe Record do
  let :described_class do Class.new super(); end
  let :instance do described_class.new; end
  
  describe 'self.attributes' do
    specify { expect(described_class).to respond_to(:attributes).with(9001).arguments }
  end # describe
  
  describe 'self.attribute' do
    specify { expect(described_class).to respond_to(:attribute).with(1).arguments }
  end # describe
  
  specify { expect(instance).to respond_to(:attributes).with(0).arguments }
  specify { expect(instance.attributes).to be == {} }
  
  describe 'with attributes defined' do
    def self.attributes; %w(foo bar baz).map(&:intern); end
    let :attributes do self.class.attributes; end
    
    before :each do
      attributes.each do |attribute|
        described_class.attribute attribute
      end # attributes
    end # before each
    
    attributes.each do |attribute|
      specify { expect(instance).to respond_to(attribute).with(0).arguments }
      specify { expect(instance).to respond_to(:"#{attribute}=").with(1).arguments }
      specify { expect(instance.attributes).to have_key attribute }
    end # each
    
    describe 'with attributes set via mutators' do
      before :each do
        attributes.each do |attribute|
          instance.send :"#{attribute}=", attribute.to_s
        end # each
      end # before :each
      
      attributes.each do |attribute|
        specify { expect(instance.send attribute).to be == attribute.to_s }
      end # each
    end # describe
    
    describe 'with attributes set at initialization' do
      let :instance do
        attrs = {}.tap { |hsh| attributes.each { |attr| hsh[attr] = attr.to_s } }
        described_class.new attrs
      end # let
      
      attributes.each do |attribute|
        specify { expect(instance.send attribute).to be == attribute.to_s }
      end # each
    end # describe
  end # describe
  
  describe 'with attributes mass-defined' do
    def self.attributes; %w(wibble wobble).map(&:intern); end
    let :attributes do self.class.attributes; end
    
    before :each do
      described_class.attributes *attributes
    end # before each
    
    attributes.each do |attribute|
      specify { expect(instance).to respond_to(attribute).with(0).arguments }
      specify { expect(instance).to respond_to(:"#{attribute}=").with(1).arguments }
      specify { expect(instance.attributes).to have_key attribute }
    end # each
  end # describe
end # describe
