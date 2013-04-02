# lib/record.rb

# Abstract class for creating simple ActiveRecord-like record objects.
class Record
  class << self
    def attributes *keys
      keys.each { |key| attribute key }
    end # method attributes
    
    # Creates an accessor key and mutator key=, which map to attributes [key]
    # and attributes [key]=, respectively; also stores the key in the
    # attribute_keys array.
    # 
    # @param [Symbol] key
    # 
    # @!macro [attach] attribute
    #   @return The $1 property
    def attribute key
      (@attribute_keys ||= []) << :"#{key}"
      
      define_method :"#{key}" do
        @attributes[key]
      end # method key
      
      define_method :"#{key}=" do |value|
        @attributes[key] = value
      end # method key=
    end # method attribute
    
    # @return The keys for attributes defined on the class. Additional
    #   attributes can also be set and accessed using the #attributes method.
    def attribute_keys
      @attribute_keys ||= []
    end # method attribute_keys
  end # class << self
  
  # @param [Hash] attributes The attribute values with which to initialize the
  #   new record. If any attributes are defined on the class but not specified
  #   here, they are initialized with nil values.
  def initialize attributes = {}
    @attributes = attributes
    
    self.class.attribute_keys.each do |key|
      @attributes[key] ||= nil
    end # each
  end # method initialize
  
  # @return [Hash] The record's stored attributes.
  def attributes
    @attributes
  end # method attributes
end # class Record
