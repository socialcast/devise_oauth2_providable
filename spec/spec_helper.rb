##
# Configure Rails Envinronment
##

ENV["RAILS_ENV"] = "test"
require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require 'rails/test_help'

##
# Setup RSpec
##

require 'rspec/rails'
RSpec.configure do |config|
  config.include Devise::TestHelpers, :type => :controller
  config.use_transactional_fixtures = true

  # Enable rendering of views for controller tests
  # See SOF question: http://bit.ly/sof-rspec-controller-view-rendering
  config.render_views
end

spec_root = File.expand_path('..', __FILE__)

##
# Setup FactoryGirl
## 

require 'factory_girl_rspec'
FactoryGirl.definition_file_paths = [File.join(spec_root, 'factories')]
FactoryGirl.find_definitions

require 'shoulda-matchers'

##
# Run Migrations
##

ActiveRecord::Migrator.migrate(File.expand_path("dummy/db/migrate/", spec_root))

##
# Load supporting files
##

Dir["#{spec_root}/support/**/*.rb"].each { |f| require f }