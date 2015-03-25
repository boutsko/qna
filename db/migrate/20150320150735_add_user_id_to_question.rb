class AddUserIdToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :user_id, :integer, index: true
  end
end
