# "{'foo': 'bar'}".should match_json {:foo => :bar}
RSpec::Matchers.define :match_json do |expected|
  match do |actual|
    JSON.parse(actual) == JSON.parse(expected.to_json)
  end
end
