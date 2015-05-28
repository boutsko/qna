class Api::V1::AnswersController < Api::V1::BaseController
  before_action :load_question, except: :show

  authorize_resource
  
  def index
    respond_with (@answers = @question.answers)
  end

  def show
    respond_with Answer.find(params[:id])
  end
  
  def create
    @answer = @question.answers.create answer_params.merge(user_id: current_resource_owner.id)
    respond_with @answer
  end

  private

  def load_question
    @question = Question.find(params[:question_id])
  end

  def answer_params
    strong_params = params.require(:answer).permit(:body)
  end

end
