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
      t.string :can_teach
      t.string :can_learn
    end
  end
end
