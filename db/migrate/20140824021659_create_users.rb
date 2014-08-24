class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :provider
      t.string :provider_uid
      t.string :provider_token
      t.datetime :provider_token_expires_at
      t.string :first_name
      t.string :last_name
      t.string :email
      t.text :bio
      t.string :can_teach, array: true, default: []
      t.string :can_learn, array: true, default: []
    end

    add_index :users, [:provider, :provider_uid], unique: true
  end
end
