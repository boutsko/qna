class Api::V1::AnswersController < Api::V1::BaseController
  before_action :load_question, except: :show

  def index
    respond_with (@answers = @question.answers)
  end

  def show
    respond_with Answer.find(params[:id])
  end
  
  def create
    respond_with(@answer = @question.answers.create(answer_params))
  end

  private

  def load_question
    @question = Question.find(params[:question_id])
  end

  def answer_params
    strong_params = params.require(:answer).permit(:body)
    strong_params.merge(user_id: current_resource_owner.id)
  end

end
