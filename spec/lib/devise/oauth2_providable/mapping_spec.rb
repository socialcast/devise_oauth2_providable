require 'spec_helper'

describe Devise::Oauth2Providable::Mapping do

  let (:mapping_class) { Devise::Oauth2Providable::Mapping }

  describe ".scope_name" do
    context "when given a plural string name ('members')" do
      subject { mapping_class.scope_name('members') }

      it { subject.should be_a(Symbol) }
      it { subject.should eql(:member) }
    end

    context "when given a singular name as a string ('member')" do
      subject { mapping_class.scope_name('member') }

      it { subject.should be_a(Symbol) }
      it { subject.should eql(:member) }
    end

    context "when given a plural name as a symbol (:members)" do
      subject { mapping_class.scope_name(:members) }

      it { subject.should be_a(Symbol) }
      it { subject.should eql(:member) }
    end

    context "when given a singular name as a symbol (:member)" do
      subject {mapping_class.scope_name(:member)}

      it { subject.should be_a(Symbol) }
      it { subject.should eql(:member) }
    end

    context "when :scope_name is specified in the options hash (:members, :scope_name => 'user')" do
      subject { mapping_class.scope_name(:members, :scope_name => 'users') }

      it { subject.should be_a(Symbol) }
      it "the scope name is set to the value without modification" do
        subject.should eql(:users)
      end
    end
  end

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

  describe "#devise_scope" do
    let (:devise_scope) { stub() }
    it "returns the devise mapping object" do
      Devise.mappings.should_receive(:[]).with(:user).and_return(devise_scope)

      mapping = mapping_class.new(:users)

      mapping.devise_scope.should eql(devise_scope)
    end
  end

  context "when no model overrides are specified in the scope's config initializer" do

    subject { mapping_class.new(:users) }
    before(:each) do
      ::Rails.application.config.
        stub_chain(:devise_oauth2_providable, :scope_settings).
        and_return({})
    end

    it "#models contains the default models" do
      subject.models.should eql({
        :access_token  => 'Devise::Oauth2Providable::AccessToken',
        :client        => 'Devise::Oauth2Providable::Client',
        :refresh_token => 'Devise::Oauth2Providable::RefreshToken',
        :user          => 'User'
      })
    end

    it "#access_token returns the AccessToken model constant" do
      subject.access_token.should eql(Devise::Oauth2Providable::AccessToken)
    end

    it "#client returns the Client model constant" do
      subject.client.should eql(Devise::Oauth2Providable::Client)
    end

    it "#refresh_token returns the RefreshToken model constant" do
      subject.refresh_token.should eql(Devise::Oauth2Providable::RefreshToken)
    end

    it "#user returns the correct User model constant" do
      subject.user.should eql(User)
    end
  end

  context "when model overrides are specified in the scope's config initializer" do
    class MyTotallyAwesomeUser 
    end

    subject { mapping_class.new(:users) }
    before(:each) do
      ::Rails.application.config.
        stub_chain(:devise_oauth2_providable, :scope_settings).
        and_return({:user => {:models => {:user => 'MyTotallyAwesomeUser'}}})
    end

    it "#models contains the overriden models" do
      subject.models.should eql({
        :access_token  => 'Devise::Oauth2Providable::AccessToken',
        :client        => 'Devise::Oauth2Providable::Client',
        :refresh_token => 'Devise::Oauth2Providable::RefreshToken',
        :user          => 'MyTotallyAwesomeUser'
      })
    end

    it "#access_token returns the AccessToken model constant" do
      subject.access_token.should eql(Devise::Oauth2Providable::AccessToken)
    end

    it "#client returns the Client model constant" do
      subject.client.should eql(Devise::Oauth2Providable::Client)
    end

    it "#refresh_token returns the RefreshToken model constant" do
      subject.refresh_token.should eql(Devise::Oauth2Providable::RefreshToken)
    end

    it "#user returns the correct User model constant" do
      subject.user.should eql(MyTotallyAwesomeUser)
    end
  end

  describe "#path_prefix" do
    context "is specified" do
      subject { mapping = mapping_class.new(:users, {:path_prefix => "member"}) }

      it "is set in the mapping object" do
        subject.path_prefix.should eql("member")
      end
    end
  end

  describe "#controllers" do
    context "when custom controllers are specified" do
      context "and all the defaults are overridden" do
        it "the custom ones are used instead of defaults" do
          controllers = {:authorizations => "authorizations", :tokens => "tokens"}

          mapping = mapping_class.new(:users, {:controllers => controllers})

          mapping.controllers.should eql(controllers)
        end
      end

      context "and only some of the defaults are overridden" do
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
end
