class Api::V1::AnswersController < Api::V1::BaseController
  before_action :load_question

  def index
    respond_with (@answers = @question.answers)
  end

  def create
    respond_with(@answer = @question.answers.create(answer_params))
  end

  private

  def load_question
    @question = Question.find(params[:question_id])
  end

  def answer_params
    strong_params = params.require(:answer).permit(:body, attachments_attributes: [:id, :file, :_destroy])
  end

end
