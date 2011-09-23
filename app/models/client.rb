class Client
  include Mongoid::Document

  before_validation :init_secret, :on => :create, :unless => :secret?
  
  validates_presence_of :name, :website, :redirect_uri, :secret
  has_many :access_tokens
  has_many :refresh_tokens
  has_many :authorization_codes
  
  field :name
  field :redirect_uri
  field :website
  field :secret
  
  def Client.find_by_identifier(id)
    Client.first(:conditions => {:id => id})
  end
  
  def identifier
    return self.id.to_s
  end
  
  private
  def init_secret
    self.secret = Devise::Oauth2Providable.random_id
  end
end
