class Client < ActiveRecord::Base
  has_many :access_tokens
  has_many :refresh_tokens

  before_validation :setup, :on => :create
  validates :name, :website, :redirect_uri, :secret, :presence => true
  validates :identifier, :presence => true, :uniqueness => true

  private

  def setup
    self.identifier = ActiveSupport::SecureRandom.urlsafe_base64(6)
    self.secret = ActiveSupport::SecureRandom.urlsafe_base64
  end
end
