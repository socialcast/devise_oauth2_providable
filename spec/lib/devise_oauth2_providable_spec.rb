require 'spec_helper'

describe Devise::Oauth2Providable do
  it 'should be defined' do
    # success
  end

  describe "#mapping" do
    let(:mock_mapping) { stub(:scope_name => scope_name) }
    let(:scope_name) { :user }
    let(:name) { "users" }
    let(:options) { {} }

    before(:each) do
      Devise::Oauth2Providable.mappings.clear
    end

    context "when the mapping does not exist" do
      before(:each) do
        Devise::Oauth2Providable::Mapping.
          should_receive(:new).
          with(name, options).
          and_return(mock_mapping)
        Devise::Oauth2Providable::Mapping.
          should_receive(:scope_name).
          with(name, options).
          and_return(scope_name)
      end

      subject { Devise::Oauth2Providable.mapping(name, options) }

      it "creates a new mapping object with specified name and options" do
        subject
      end

      it "assigns the new mapping object to the .mappings hash with the scope name as key" do
        subject
        Devise::Oauth2Providable.mappings[:user].should eql(mock_mapping)
      end

      it "returns the new mapping" do
        subject.should eql(mock_mapping)
      end
    end

    context "when the mapping already exists" do
      let(:options) { {:a => :b} }

      before(:each) do
        mock_mapping.stub(:apply_options).and_return(mock_mapping)
        Devise::Oauth2Providable.mappings[scope_name] = mock_mapping
        Devise::Oauth2Providable::Mapping.
          should_receive(:scope_name).
          with(name, options).
          and_return(scope_name)
      end

      subject { Devise::Oauth2Providable.mapping(name, options) }

      it "does not create a new mapping object" do
        Devise::Oauth2Providable::Mapping.should_not_receive(:new)

        subject
      end

      it "applies the passed options to the mapping" do
        mock_mapping.should_receive(:apply_options).with(options)

        subject
      end

      it "returns the mapping object" do
        subject.should eql(mock_mapping)
      end
    end
  end
end
