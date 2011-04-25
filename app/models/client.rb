class Client < ActiveRecord::Base
  has_many :access_tokens
  has_many :refresh_tokens

  before_validation :setup, :on => :create
  validates :name, :website, :redirect_uri, :secret, :presence => true
  validates :identifier, :presence => true, :uniqueness => true

  private

  def setup
    self.identifier = ActiveSupport::SecureRandom.base64(16)
    self.secret = ActiveSupport::SecureRandom.base64
  end
end
