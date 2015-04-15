class RenameToAttachable < ActiveRecord::Migration
  def change
    remove_index :attachments, :attachmentable_id
    rename_column :attachments, :attachmentable_id, :attachable_id
    add_index :attachments, :attachable_id

    remove_index :attachments, :attachmentable_type
    rename_column :attachments, :attachmentable_type, :attachable_type
    add_index :attachments, :attachable_type
  end
end

# class ConvertAttachmentToPolymorphic < ActiveRecord::Migration
#   def change
#     remove_index :attachments, :question_id
#     rename_column :attachments, :question_id, :attachmentable_id
#     add_index :attachments, :attachmentable_id

#     add_column :attachments, :attachmentable_type, :string
#     add_index :attachments, :attachmentable_type
#   end
# end
