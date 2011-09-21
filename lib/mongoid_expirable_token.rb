module MongoidExpirableToken
  def self.included(klass)
    klass.class_eval do
      scope :valid, -> { where(:expires_at.gt => Time.now) }
      
      def self.find_by_token token
        self.first(:conditions => {:token => token})
      end

    end
  end

  field :token
  field :expires_at, :type => DateTime

  def expires_in
    self.expires_at.to_i - Time.now.to_i
  end
end