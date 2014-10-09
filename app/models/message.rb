class Message < ActiveRecord::Base
  belongs_to :conversation
  
  validates_length_of :body, minimum: 15, too_short: "Make that a little longer", maximum: 600, too_long: "Just 600 words please"
end
