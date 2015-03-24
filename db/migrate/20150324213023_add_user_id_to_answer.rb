class AddUserIdToAnswer < ActiveRecord::Migration
  def change
    add_column :answers, :user_id, :integer, index: true
  end
end
