class Client < ActiveRecord::Base
  has_many :access_tokens
  has_many :refresh_tokens

  before_validation :init_identifier, :on => :create, :unless => :identifier?
  before_validation :init_secret, :on => :create, :unless => :secret?
  validates :name, :website, :redirect_uri, :secret, :presence => true
  validates :identifier, :presence => true, :uniqueness => true

  private

  def init_identifier
    self.identifier = ActiveSupport::SecureRandom.base64(16)
  end
  def init_secret
    self.secret = ActiveSupport::SecureRandom.base64
  end
end
