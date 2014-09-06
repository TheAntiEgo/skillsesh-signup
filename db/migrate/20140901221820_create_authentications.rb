class CreateAuthentications < ActiveRecord::Migration
  def change
    create_table :authentications do |t|
      t.string :provider
      t.string :provider_id
      t.string :provider_token
      t.datetime :provider_token_expires_at
      t.integer :user_id

      t.timestamps
    end

    add_index :authentications, [:provider, :provider_id], unique: true
  end
end
