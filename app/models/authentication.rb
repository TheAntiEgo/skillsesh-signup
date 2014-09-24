class Authentication < ActiveRecord::Base
  ##
  # Validations
  ##

  validates_presence_of :user, :provider, :provider_id, :provider_token, :provider_token_expires_at
  validates_associated :user

  ##
  # Associations
  ##

  belongs_to :user
  
  ##
  # Class methods
  ##
  def self.from_omniauth(auth)
    new do |a|
      a.provider = auth[:provider]
      a.provider_id = auth[:uid]
      a.provider_token = auth[:credentials][:token]
      a.provider_token_expires_at = auth[:credentials][:expires_at]
    end
  end
  
  def self.with_omniauth(auth)
    find_by :provider => auth[:provider], :provider_id => auth[:uid]
  end
  
  def self.has_omniauth?(auth)
    exists? :provider => auth[:provider], :provider_id => auth[:uid]
  end
end
