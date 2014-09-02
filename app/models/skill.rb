class Skill < ActiveRecord::Base
  ##
  # Validations
  ##

  validates_presence_of :name
  validates_length_of :name, minimum: 3

  ##
  # Associations
  ##

  has_and_belongs_to_many :courses
end
