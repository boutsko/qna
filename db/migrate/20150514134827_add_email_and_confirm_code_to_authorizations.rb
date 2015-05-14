class AddEmailAndConfirmCodeToAuthorizations < ActiveRecord::Migration
  def change
    add_column :authorizations, :email, :string
    add_column :authorizations, :confirm_code, :string
  end
end
