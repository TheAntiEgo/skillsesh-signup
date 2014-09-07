class ChangeExpiresatFieldOnAuthentications < ActiveRecord::Migration
  def change
    change_column :authentications, :provider_token_expires_at, :string
  end
end
