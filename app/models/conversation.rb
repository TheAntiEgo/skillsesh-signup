class Conversation < ActiveRecord::Base
  belongs_to :customer
  belongs_to :merchant
  belongs_to :course
  has_many :messages
end
