require 'spec_helper'

describe Devise::Oauth2Providable::Mapping do

  let (:mapping_class) { Devise::Oauth2Providable::Mapping }

  describe "devise_oauth_for" do


    describe "#scope_name" do
      it "is the singular version of the name provided in initializer" do
        mapping = mapping_class.new(:users)

        mapping.scope_name.should == :user
      end

      it "can be overriden by the :scope_name option" do
        mapping = mapping_class.new(:users, :scope_name => 'member')

        mapping.scope_name.should == :member
      end
    end

    describe "devise_scope" do
      let (:devise_scope) { stub() }
      it "returns the devise mapping object" do
        Devise.mappings.should_receive(:[]).with(:user).and_return(devise_scope)

        mapping = mapping_class.new(:users)

        mapping.devise_scope.should eql(devise_scope)
      end
    end

    describe "path_prefix" do
      context "is specified" do
        subject { mapping = mapping_class.new(:users, {:path_prefix => "member"}) }

        it "is set in the mapping object" do
          subject.path_prefix.should eql("member")
        end
      end
    end

    context "when custom controllers are specified" do
      it "the custom ones are used instead of defaults" do
        controllers = {:authorizations => "authorizations", :tokens => "tokens"}

        mapping = mapping_class.new(:users, {:controllers => controllers})

        mapping.controllers.should eql(controllers)
      end

      it "the custom ones should be merged with defaults" do
        controllers = {:authorizations => "authorizations"}

        mapping = mapping_class.new(:users, {:controllers => controllers})

        mapping.controllers.should eql({
          :authorizations => "authorizations",
          :tokens         => "devise/oauth2_providable/tokens"
        })
      end
    end
  end
end
