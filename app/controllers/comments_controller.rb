# coding: utf-8
class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_commentable, only: :create
  before_action :load_comment, only: :destroy

  def create
    @comment = @commentable.comments.create(comment_params)
  end

  def destroy
    @comment.destroy
  end

  private

  def load_commentable
    @commentable = commentable_klass.find(params[commentable_id_s])

  end

  def load_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    strong_params = params.require(:comment).permit(:body, :commentable)
  end

  def commentable_name
    params[:commentable]
  end
  
  def commentable_id_s
    "#{commentable_name}_id"
  end
  
  
  def commentable_klass
    params[:commentable].classify.constantize
  end

end

