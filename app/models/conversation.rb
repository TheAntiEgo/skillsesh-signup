class Conversation < ActiveRecord::Base
  belongs_to :customer, class_name: "User"
  belongs_to :merchant, class_name: "User"
end
