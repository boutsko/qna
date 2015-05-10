class AnswersController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :load_answer, only: [ :show, :edit, :update, :destroy, :best ]
  before_action :load_question, only: [ :create, :update ]
  before_action :user_created_answer?, only: [ :update, :destroy ]
  before_action :user_created_question?, only: [:best]

  respond_to :html
  respond_to :js

  include Voted
  
  def index
    respond_with(@answers = @question.answers)
  end

  def show
  end

  def new
    respond_with(@answer = @question.answers.new)
  end

  def edit
  end

  def create
    respond_with(@answer = @question.answers.create(answer_params))
  end

  def update
    respond_with @answer
  end

  def best
    @answers = @answer.question.answers
    @answer.make_best
  end
  
  def destroy
    respond_with(@answer.destroy)
  end

  private

  def load_question
    @question = params.has_key?(:question_id) ? Question.find(params[:question_id]) : @answer.question
  end
  
  def load_answer
    @answer = Answer.find(params[:id])
  end

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
    strong_params = params.require(:answer).permit(:body, attachments_attributes: [:id, :file, :_destroy])
    strong_params.merge(user_id: current_user.id) if user_signed_in?
  end

end
