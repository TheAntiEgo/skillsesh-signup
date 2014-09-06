class Profile < ActiveRecord::Base
  ##
  # Validations
  ##
  validates_presence_of :user, :first_name, :last_name
  validates_length_of :bio, minimum: 150, maximum: 500
  validates_associated :user

  ##
  # Associations
  ##
  belongs_to :user
  has_and_belongs_to_many :skills
  
  ##
  # Class methods
  ##
  def self.from_omniauth(auth)
    new do |profile|
      profile.first_name = auth.info.first_name
      profile.last_name = auth.info.last_name
      profile.photo = auth.extra.raw_info.pictureUrls[:values].first || auth.info.image
    end
  end
end
