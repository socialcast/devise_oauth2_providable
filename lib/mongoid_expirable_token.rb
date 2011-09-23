module MongoidExpirableToken
  def self.included(klass)
    klass.class_eval do
      scope :valid, -> { where(:expires_at.gt => Time.now) }
      
      def self.find_by_token token
        self.first(:conditions => {:token => token})
      end

    end
  end

  def expires_in
    self.expires_at.utc.to_i - Time.now.utc.to_i
  end
  
  def expired!
    self.expires_at = Time.now.utc - 1.day
    self.save!
  end
  
end