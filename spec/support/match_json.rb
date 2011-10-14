# "{'foo': 'bar'}".should match_json {:foo => :bar}
RSpec::Matchers.define :match_json do |expected|
  match do |actual|
    ActiveSupport::JSON.backend.decode(actual) == ActiveSupport::JSON.backend.decode(expected.to_json)
  end
end
