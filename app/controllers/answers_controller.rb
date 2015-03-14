class AnswersController < ApplicationController
  before_action :load_question
  before_action :load_answer, only: :show
  
  def index
    @answers = @question.answers
  end

  def show
  end

  def new
    @answer = @question.answers.new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end


  def load_question
    @question = Question.find(params[:question_id])
  end

  def load_answer
    @answer = @question.answers.find(params[:id])
  end
end

