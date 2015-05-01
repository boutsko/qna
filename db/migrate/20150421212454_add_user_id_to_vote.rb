class AddUserIdToVote < ActiveRecord::Migration
  def change
    add_column :votes, :user_id, :integer, index: true
  end
end
