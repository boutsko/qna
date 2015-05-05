class AddIndexToComment < ActiveRecord::Migration
  def change
    add_index :comments, :commentable_type
  end
end
