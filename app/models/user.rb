class User < ActiveRecord::Base
  ##
  # Validations
  ##
  validates_presence_of :email 

  ##
  # Associations
  ##
  has_many :authentications, dependent: :destroy
  has_many :courses, foreign_key: 'instructor_id'
  has_many :questions, class_name: 'Conversation', foreign_key: 'customer_id'
  has_many :answers, class_name: 'Conversation', foreign_key: 'merchant_id'
  has_many :messages
  has_one :schedule
  has_one :preference
  has_and_belongs_to_many :skills, :join_table => 'users_skills'
  

  ##
  # Class methods
  ##
  def self.from_omniauth(auth)
    new do |user|
      user.first_name = auth[:info][:first_name]
      user.last_name = auth[:info][:last_name]
      user.email = auth[:info][:email]
      user.remember_token = SecureRandom.uuid
      if auth[:provider] == 'linkedin'
        user.photo = auth[:extra][:raw_info][:pictureUrls][:values].first
      else
        user.photo = auth[:info][:image]
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
        self.skills.create!(:name => s)
      else
        self.skills << Skill.find_by!(:name => s) unless self.skills.include?(Skill.find_by(:name => s))
      end
    end      
  end

  def messages
    # Need a sane source of truth for all conversations a user is uniquely
    # participating in.
    return self.questions if self.answers == []
    return self.answers if self.questions == []
    return self.answers.merge(self.questions)
  end
end
