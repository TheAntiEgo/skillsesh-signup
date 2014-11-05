class NullTrueOnBio < ActiveRecord::Migration
  def change
    change_column :users, :bio, :text, :null => true
  end
end
