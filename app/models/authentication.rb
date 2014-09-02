class Authentication < ActiveRecord::Base
  ##
  # Validations
  ##

  validates_presence_of :user, :provider, :provider_id, :provider_token, :provider_token_expires_at
  validates_associated :user

  ##
  # Associations
  ##

  belongs_to :user
end
