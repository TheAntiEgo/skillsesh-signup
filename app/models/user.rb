class User < ActiveRecord::Base

  has_attached_file :photo
  validates_attachment_content_type :photo, content_type: /\Aimage\/jp[e]?g\Z/

  ##
  # Class methods
  ##
  
  # TODO Refactor: Method shouldn't query and assign. Sequester control of 
  # operations to controller
  def self.from_omniauth(auth)
    where(['provider = ? and provider_uid = ?', auth.slice(:provider), auth.slice(:uid)]).first_or_create do |user|
      user.provider = auth.provider
      user.provider_uid = auth.uid
      user.provider_token = auth.credentials.token
      user.provider_token_expires_at = auth.credentials.expires_at
      user.remember_token = SecureRandom.uuid
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.email = auth.info.email

      if auth.info.image && auth.provider == 'facebook'
        user.photo = URI.parse(auth.info.image.gsub('http', 'https'))
      else
        user.photo = URI.parse(auth.info.image)
      end
    end
  end

  ##
  # Instance methods
  #
  
  # TODO Write teachable/learnable accessors
end
