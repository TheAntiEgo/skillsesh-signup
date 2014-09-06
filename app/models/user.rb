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

  ##
  # Instance methods
  ##
  
end
