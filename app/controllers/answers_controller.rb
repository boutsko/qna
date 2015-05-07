class AnswersController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :load_answer, only: [ :show, :edit, :update, :destroy, :best ]
  before_action :load_question, only: [ :create, :update ]
  before_action :user_created_answer?, only: [ :update, :destroy ]
  before_action :user_created_question?, only: [:best]

  include Voted
  
  def index
    @answers = @question.answers
  end

  def show
  end

  def new
    @answer = @question.answers.new
  end

  def edit
  end

  def create
    @answer = @question.answers.build(answer_params)
    @answer.user = current_user
    @answer.save    
    respond_to do |format|
      format.js
    end
  end

  def update
    @answer.update(answer_params)
  end

  def best
    @answers = @answer.question.answers
    @answer.make_best
  end
  
  def destroy
    @answer.destroy
  end

  private


  def load_question
    @question =
      if params.has_key?(:question_id)
        Question.find(params[:question_id])
      else
        @answer.question
      end
  end

  def load_answer
    @answer = Answer.includes(:attachments, :votes, :comments).find(params[:id])
  end
  
  # def load_answer
  #   @answer = Answer.find(params[:id])
  # end

  def user_created_answer?
    if @answer.user_id != current_user.id
      redirect_to @question, notice: 'Answer can be modified/deleted strictly by its author only'
    end
  end

  def user_created_question?
    unless @answer.question.user_id == current_user.id
      render status: 403, text: "Only author of question can mark best answer"
    end
  end
  
  def answer_params
    params.require(:answer).permit(:body, attachments_attributes: [:id, :file, :_destroy])
  end

end
