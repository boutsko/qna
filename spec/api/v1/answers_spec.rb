require 'rails_helper'

describe 'Answers API' do
  describe 'GET /index' do
    context 'unauthorized' do
      let!(:question) { create :question }
      
      it 'returns 401 status if there is no access_token' do
        get api_v1_question_answers_path(question), format: :json
        expect(response.status).to eq 401
      end

      it 'returns 401 status if access_token is invalid ' do
        get api_v1_question_answers_path(question), format: :json, access_token: '1234'
        expect(response.status).to eq 401
      end
    end

    context 'authorized' do
      let(:path_resource) { "answers/0" }
      let(:access_token) { create(:access_token) }
      let(:question) { create(:question) }
      let!(:answer) { create(:answer, question: question) }
      let!(:answer2) { create(:answer, question: question) }
      let!(:answers) { [answer, answer2] }

      let!(:comments) { create_list :comment, 3, commentable: resource }
      let!(:resource) { answer } 

      before { get api_v1_question_answers_path(question), format: :json, access_token: access_token.token }
      
      it 'returns 200 status code' do
        expect(response).to be_success
      end

      it 'returns list of answers' do
        expect(response.body).to have_json_size(answers.size).at_path("answers")
      end
    end
  end
end
