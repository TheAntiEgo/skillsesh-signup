class Profile < ActiveRecord::Base
  ##
  # Validations
  ##

  ##
  # Associations
  ##
  belongs_to :user
  has_many :courses, :dependent => :destroy
  has_and_belongs_to_many :skills
  
  ##
  # Class methods
  ##
  def self.from_omniauth(auth)
    new do |profile|
      profile.first_name = auth[:info][:first_name]
      profile.last_name = auth[:info][:last_name]
      if auth[:provider] == 'linkedin'
        profile.photo = auth[:extra][:raw_info][:pictureUrls][:values].first
      else
        profile.photo = auth[:info][:image]
      end
    end
  end
  
  ##
  # Instance methods
  ##
  def skills=(str_or_array) #expects a string
    list = str_or_array.split(/\,/).map {|s| s.downcase.strip} if str_or_array.kind_of? String
    list.each do |s|
      self.skills << Skill.new(:name => s)
    end      
  end
end
