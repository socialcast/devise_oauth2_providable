# Configure Rails Envinronment
ENV["RAILS_ENV"] = "test"
require File.expand_path("../dummy/config/environment.rb",  __FILE__)

require 'pry'
require 'rspec/rails'
require 'shoulda-matchers'

require 'factory_girl_rspec'
FactoryGirl.definition_file_paths = [
    File.join(File.dirname(__FILE__), 'factories')
]
FactoryGirl.find_definitions

ENGINE_RAILS_ROOT=File.join(File.dirname(__FILE__), '../')

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[File.join(ENGINE_RAILS_ROOT, "spec/support/**/*.rb")].each {|f| require f }

RSpec.configure do |config|
  config.include Devise::TestHelpers, :type => :controller

  config.use_transactional_fixtures = true

  # enable rendering of views for controller tests
  # see http://stackoverflow.com/questions/4401539/rspec-2-how-to-render-views-by-default-for-all-controller-specs
  config.render_views
end
