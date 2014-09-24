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

  def add_skills_from_str(p)
    str = p[:skills]
    list = str.split(/\,/).map {|s| s.downcase.strip}
    list.each do |s|
      unless Skill.exists?(:name => s)
        self.skills << Skill.new(:name => s)
      else
        self.skills << Skill.find_by(:name => s) unless self.skills.include?(Skill.find_by(:name => s))
      end
    end      
  end
end
