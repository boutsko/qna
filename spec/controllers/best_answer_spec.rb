require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:question) { create(:question, user: user) }
  let(:answer) { create(:answer, question: question, user: user) }
  let(:answers) { create_list(:answer, 2, question: question, user: user) }


  describe 'PATCH #update' do

    before do
      sign_in question.user
    end
    
    context 'Question\s author' do
      
      it 'changes answer to be the best one' do
        patch :best, id: answer, question_id: question, format: :js
        answer.reload 
        expect(answer.best).to be true 
      end 
    end
  end
end
