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
end
