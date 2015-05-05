module Commented
  extend ActiveSupport::Concern
  
  included do
    before_action :load_commentable_resource, only: [:like, :dislike, :withdraw_comment]
    # after_action :update_comments, only: [:like, :dislike, :withdraw_comment]
    helper_method :user_can_comment_for?
  end

  def like
    @commentable.liked_by(current_user)
    update_comments
  end

  def dislike
    @commentable.disliked_by(current_user)
    update_comments
  end

  def withdraw_comment
    @commentable.withdraw_comment_by(current_user)
    update_comments
  end

  private

  def load_commentable_resource
    @commentable = controller_name.classify.constantize.find(params[:id])
  end

  def check_user_can_comment
    unless user_can_comment_for(@commentable)
      render status: :forbidden
    end
  end

  def update_comments
    render 'layouts/commentable/update'
  end
end

