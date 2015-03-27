class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :load_question, only: [:show, :edit, :update, :destroy]
  before_action :user_created_question?, only: [:update, :destroy]
  def index
    @questions = Question.all
  end

  def show
  end

  def new
    @question = Question.new
  end

  def edit
  end

  def create
    @question = Question.create(question_params)
    if @question.save
      redirect_to @question, notice: 'Question created'
    else
      flash[:alert] = 'ERROR: Question not created'
      render :new
    end
  end

  def update
    if @question.update(question_params) 
      redirect_to :question
    else
      render :edit
    end 
  end

  def destroy
    @question.destroy! 
    redirect_to questions_path, notice: 'Question destroyed'
  end

  private
  
  def load_question
    @question = Question.find(params[:id])
  end

  def user_created_question?
    if @question.user_id != current_user.id
      redirect_to @question, notice: 'Question can be modified/deleted strictly by its author only'
    end
  end
  
  def question_params
    params.require(:question).permit(:title, :body)
  end
end
