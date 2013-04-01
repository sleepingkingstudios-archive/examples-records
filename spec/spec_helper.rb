# spec/spec_helper.rb

require 'factory_girl'

RSpec.configure do |config|
  config.color_enabled = true
end # configure

# require factories, support files
Dir[File.dirname(__FILE__) + "/support/**/*.rb"].each { |f| require f }
