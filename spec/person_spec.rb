# spec/person_spec.rb

require 'spec_helper'

require 'person'

describe Person do
  let :instance do described_class.new; end
  
  def self.attributes
    %w(last_name first_name middle_initial gender date_of_birth
      favorite_color).map(&:intern)
  end # class method attributes
  let :attributes do self.class.attributes; end
  
  attributes.each do |attribute|
    specify { expect(instance).to respond_to(:"#{attribute}").with(0).arguments }
    specify { expect(instance).to respond_to(:"#{attribute}=").with(1).arguments }
  end # each
end # describe
