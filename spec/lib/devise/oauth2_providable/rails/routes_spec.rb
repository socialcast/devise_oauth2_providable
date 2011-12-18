require 'spec_helper'

describe Devise::Oauth2Providable::Rails::Routes do
  let (:devise_mod) { Devise::Oauth2Providable }
  describe "#devise_oauth_for" do

    let(:scope_name) { :users }
    let(:options) { {} }
    let(:mapper) do
      set = stub(:resources_path_names => {:new => 'new', :edit => 'edit'}).as_null_object
      ActionDispatch::Routing::Mapper.new(set)
    end
    let(:mock_mapping) do
      stub(
        :path_prefix => '',
        :scope_name => scope_name,
        :controllers => Devise::Oauth2Providable::Mapping.default_controllers
      )
    end

    it "creates a new mapping" do
      devise_mod.should_receive(:mapping).
        with(scope_name, options).
        and_return(mock_mapping)

      mapper.devise_oauth_for(scope_name)
    end
  end
end
