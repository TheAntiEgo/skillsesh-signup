class User < ActiveRecord::Base
  ##
  # Validations
  ##
  validates_presence_of :email 

  ##
  # Associations
  ##
  has_many :authentications, dependent: :destroy
  has_one :profile, dependent: :destroy
  has_many :courses, foreign_key: 'instructor_id'
  has_many :questions, class_name: 'Conversation', foreign_key: 'customer_id'
  has_many :answers, class_name: 'Conversation', foreign_key: 'merchant_id'
  
  ##
  # Class methods
  ##

  ##
  # Instance methods
  ##
  def messages
    # Need a sane source of truth for all conversations a user is uniquely
    # participating in.
    return self.questions if self.answers == []
    return self.answers if self.questions == []
    return self.answers.merge(self.questions)
  end
end
