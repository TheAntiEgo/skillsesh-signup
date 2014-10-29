class AddParentChildToMessages < ActiveRecord::Migration
  def change
    change_table :messages do |t|
      t.references :parent, :unique => true, :index => true
    end
  end
end
