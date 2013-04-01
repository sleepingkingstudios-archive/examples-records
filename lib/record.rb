# lib/record.rb

class Record
  class << self
    def attributes *keys
      keys.each { |key| attribute key }
    end # method attributes
    
    def attribute key
      (@attribute_keys ||= []) << :"#{key}"
      
      define_method :"#{key}" do
        @attributes[key]
      end # method key
      
      define_method :"#{key}=" do |value|
        @attributes[key] = value
      end # method key=
    end # method attribute
    
    def attribute_keys
      @attribute_keys ||= []
    end # method attribute_keys
  end # class << self
  
  def initialize attributes = {}
    @attributes = attributes
    
    self.class.attribute_keys.each do |key|
      @attributes[key] ||= nil
    end # each
  end # method initialize
  
  def attributes
    @attributes
  end # method attributes
end # class Record
