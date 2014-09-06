class User < ActiveRecord::Base

  ##
  # Validations
  ##

  validates_presence_of :email 

  ##
  # Associations
  ##
  has_many :authentications, dependent: :destroy
  has_one :profile
  has_many :courses, foreign_key: 'instructor_id'
  
  ##
  # Class methods
  ##
  
  def self.from_omniauth(auth)
    where(['provider = ? and provider_uid = ?', auth.slice(:provider), auth.slice(:uid)]).first_or_create! do |user|
      user.provider = auth.provider
      user.provider_uid = auth.uid
      user.provider_token = auth.credentials.token
      user.provider_token_expires_at = auth.credentials.expires_at
      user.remember_token = SecureRandom.uuid
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.email = auth.info.email
      user.photo = auth.extra.raw_info.pictureUrls[:values].first || auth.info.image
    end
  end

  ##
  # Instance methods
  #
  
  # TODO Write teachable/learnable accessors
end
