class Preference < ActiveRecord::Base
  belongs_to :user, :inverse_of => :preference
end
