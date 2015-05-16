class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :load_question, only: [:show, :edit, :update, :destroy]
  before_action :user_created_question?, only: [:update, :destroy]
  before_action :build_answer, only: [:show]

  respond_to :html

  authorize_resource
  
  include Voted
  
  def index
    respond_with(@questions = Question.all)
  end

  def show
    respond_with(@question)
  end

  def new
    respond_with(@question = Question.new)
  end

  def edit
  end
  
  def create
    @question = Question.new(question_params)
    @question.user = current_user
    @question.save
    respond_with(@question)
  end

  def update
    @question.update(question_params)
    respond_with(@question)
  end

  def destroy
    respond_with(@question.destroy!)
  end

  private

  def build_answer
    @answer = @question.answers.build
  end
  
  def load_question
    @question = Question.find(params[:id])
  end

  def user_created_question?
    if @question.user_id != current_user.id
      redirect_to @question, notice: 'Question can be modified/deleted strictly by its author only'
    end
  end
  
  def question_params
    strong_params = params.require(:question).permit(:title, :body, attachments_attributes: [:id, :file, :_destroy])
  end

end
