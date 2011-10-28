module ExpirableToken
  def self.included(klass)
    klass.class_eval do
      cattr_accessor :default_lifetime
      self.default_lifetime = 1.minute

      belongs_to :user
      belongs_to :client

      after_initialize :init_token, :on => :create, :unless => :token?
      after_initialize :init_expires_at, :on => :create, :unless => :expires_at?
      validates :expires_at, :presence => true
      validates :client, :presence => true
      validates :token, :presence => true, :uniqueness => true

      # TODO: this should be a default scope once rails default_scope supports lambda's
      scope :valid, lambda {
        where(self.arel_table[:expires_at].gteq(Time.now.utc))
      }
    end
  end

  # number of seconds until the token expires
  def expires_in
    (expires_at - Time.now.utc).to_i
  end

  # forcefully expire the token
  def expired!
    self.expires_at = Time.now.utc
    self.save!
  end

  private

  def init_token
    self.token = Devise::Oauth2Providable.random_id
  end
  def init_expires_at
    self.expires_at = self.default_lifetime.from_now
  end
end

