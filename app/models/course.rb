class Course < ActiveRecord::Base
  ##
  # Validations
  ##

  validates_presence_of :instructor, :goal, :how, :requirements, :duration
  validates_associated :instructor

  ##
  # Associations
  ##
  
  belongs_to :instructor, class_name: "User"
  has_and_belongs_to_many :skills
end
