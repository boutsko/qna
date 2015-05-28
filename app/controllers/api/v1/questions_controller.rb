class Api::V1::QuestionsController < Api::V1::BaseController

  authorize_resource

  def index
    respond_with(@questions = Question.all)
  end

  def show
    respond_with @question
  end

  def create
    @question = Question.create question_params.merge(user_id: current_resource_owner.id)
    respond_with @question
  end

  private

  def question_params
    strong_params = params.require(:question).permit(:title, :body)
  end

end
