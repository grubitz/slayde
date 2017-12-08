class AddResetPasswordFieldsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :reset_password_token, :string
    add_column :users, :reset_password_sent_at, :timestamp
    add_index :users, :reset_password_token, { unique: true }
  end
end
