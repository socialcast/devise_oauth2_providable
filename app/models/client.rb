class Client
  include Mongoid::Document
  embeds_many :access_tokens
  embeds_many :refresh_tokens

  before_validation :init_secret, :on => :create, :unless => :secret?
  
  validates_presence_of :name, :website, :redirect_uri, :secret
  
  field :name
  field :redirect_uri
  field :website
  field :secret
  
  def Client.find_by_identifier(id)
    Client.first(:conditions => {:id => id})
  end
    
  private

  def init_identifier
    self.identifier = Devise::Oauth2Providable.random_id
  end
  def init_secret
    self.secret = Devise::Oauth2Providable.random_id
  end
end
