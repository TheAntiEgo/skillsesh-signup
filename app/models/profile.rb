class Profile < ActiveRecord::Base
  ##
  # Validations
  ##

  validates_presence_of :user, :first_name, :last_name
  validates_length_of :bio, minimum: 150, maximum: 500
  validates_associated :user

  ##
  # Associations
  ##

  belongs_to :user
end
