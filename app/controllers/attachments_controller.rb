class AttachmentsController < ApplicationController
  before_action :authenticate_user!, :load_attachment, :find_parent, :author?

  def destroy
    @attachment = Attachment.find(params[:id]) if params.has_key?(:id)
    @attachment.destroy
  end

  private

  def load_attachment
    @attachment = Attachment.find(params[:id]) if params.has_key?(:id)
  end

  def find_parent
    @parent = @attachment.attachable
  end

  def author?
    unless current_user.author_of?(@parent)
      render status: 403, text: "Only author can delete his files"
    end
  end
end
