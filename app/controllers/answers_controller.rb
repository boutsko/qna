class AnswersController < ApplicationController
before_action :load_question
  
  def index
    @answers = @question.answers
  end

  def show
  end

  def new
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
end
