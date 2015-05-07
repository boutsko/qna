class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_commentable, only: :create
  before_action :load_comment, only: :destroy

  def create
    @comment = @commentable.comments.create comment_params
  end

  def destroy
    @comment.destroy
  end

  private

  def load_commentable
    klass = [Question, Answer].detect{|c| params["#{c.name.underscore}_id"]}
    @commentable= klass.find(params["#{klass.name.underscore}_id"])

  end

  def load_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    strong_params = params.require(:comment).permit(:body, :commentable)
  end

end
