require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { create(:question) }
  let(:answer) { create(:answer, question: question) }
  let(:answers) { create_list(:answer, 2, question: question) }

  describe "GET #index" do
    before { get :index, question_id: question }

    it 'populates array of all answers' do
      expect(assigns(:answers)).to match_array(answers)
    end
    
    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

end
