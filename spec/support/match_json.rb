# "{'foo': 'bar'}".should match_json {:foo => :bar}
RSpec::Matchers.define :match_json do |expected|
  match do |actual|
    ActiveSupport::JSON.backend.load(actual) == ActiveSupport::JSON.backend.load(expected.to_json)
  end
end
