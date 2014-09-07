class Course < ActiveRecord::Base
  ##
  # Validations
  ##
  validates_presence_of :name, :goal, :how, :requirements, :location

  ##
  # Associations
  ##
  
  belongs_to :profile
  has_and_belongs_to_many :skills
end
