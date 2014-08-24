class User < ActiveRecord::Base

  has_attached_file :photo
  validates_attachment_content_type :photo, content_type: /\Aimage\/jp[e]?g\Z/

  def self.from_omniauth(auth)
    where(['provider = ? and provider_uid = ?', auth.slice(:provider), auth.slice(:uid)]).first_or_create do |user|
      user.provider = auth.provider
      user.provider_uid = auth.uid
      user.provider_token = auth.credentials.token
      user.provider_token_expires_at = auth.credentials.expires_at
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.email = auth.info.email
      user.photo = URI.parse(auth.info.image.gsub('http', 'https')) if auth.info.image?
    end
  end
end
