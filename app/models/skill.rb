class Skill < ActiveRecord::Base
  ##
  # Validations
  ##
  validates_presence_of :name
  validates_uniqueness_of :name

  ##
  # Associations
  ##
  has_and_belongs_to_many :users, :join_table => 'users_skills'
  has_and_belongs_to_many :courses
end
