class RemoveLearnablesFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :learnables, :string
  end
end
