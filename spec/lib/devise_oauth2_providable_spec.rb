require 'spec_helper'

describe Devise::Oauth2Providable do
  it 'should be defined' do
    # success
  end

  describe "#add_mapping" do
    let(:mock_mapping) { stub(:scope_name => scope_name) }
    let(:scope_name) { "user" }
    let(:options) { {} }

    before(:each) do
      Devise::Oauth2Providable::Mapping.
        should_receive(:new).
        with(scope_name, options).
        and_return(mock_mapping)
    end

    subject { Devise::Oauth2Providable.add_mapping(scope_name, options) }

    it "allows you to add a new mapping" do
      subject
    end

    it "returns the new mapping" do
      subject.should eql(mock_mapping)
    end

    it "assigns the mapping to the Devise::Oauth2Providable.mapping hash using scope_name" do
      subject

      Devise::Oauth2Providable.mappings[scope_name].should == mock_mapping
    end
  end
end
