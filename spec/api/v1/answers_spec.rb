require 'rails_helper'

describe 'Answers API' do
  describe 'GET /questions/:question_id/answers' do
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
      let!(:resource) { answer } 
      let!(:comments) { create_list :comment, 3, commentable: resource }
      let!(:attachments) { create_list :attachment, 1, attachable: answer }

      
      before { get api_v1_question_answers_path(question), format: :json, access_token: access_token.token }
      
      it 'returns 200 status code' do
        expect(response).to be_success
      end

      it 'returns list of answers' do
        expect(response.body).to have_json_size(answers.size).at_path("answers")
      end

      resource_attributes(:answer).each do |attr|
        it "contains #{ attr }" do
          resource_attr = resource.send(attr.to_sym).to_json
          path = "#{ path_resource }/#{ attr }"
          expect(response.body).to be_json_eql(resource_attr).at_path(path)
        end
      end

      resource_associations(:answer).each do |association|
        context "#{ association }" do
          it "includes #{ association }" do
            path = "#{ path_resource }/#{ association }"
            expect(response.body).to have_json_size(resource.send(association).count).at_path(path)
          end

          resource_attributes(association).each do |attr|
            it "#{ association.to_s.singularize } contains #{ attr }" do
              path = "#{ path_resource }/#{ association }/0/#{ attr }"
              association_attr = send(association).first.send(attr.to_sym).to_json
              expect(response.body).to be_json_eql(association_attr).at_path(path)
            end
          end
        end
      end
    end
  end

  describe "GET /answers/:id" do

    let!(:question) { create(:question) }
    let!(:resource) { answer } 
    let!(:resource) { answer }
    let(:access_token) { create(:access_token) }

    let!(:answer) { create(:answer) }
    let!(:comments) { create_list(:comment, 3, commentable: answer).reverse }
    let!(:attachments) { create_list(:attachment, 2, attachable: answer).map { |a| a.file.url }.reverse }

    let(:path_resource) { "answers/#{answer.id}" }
    
    context 'unauthorized' do
      it 'returns 401 status if there is no access_token' do
        get api_v1_answer_path(answer), format: :json
      end
    end

    context 'authorized' do
      context 'with valid answer id' do

        before { get api_v1_answer_path(answer), access_token: access_token.token, format: :json }

        %w(id body created_at updated_at).each do |attr|
  
          it "contains #{attr}" do
            expect(response.body).to be_json_eql(answer.send(attr.to_sym).to_json).at_path("answer/#{attr}")
          end
        end

        %w(password encrypted_password).each do |attr|

          it "does not contains #{attr} " do
            expect(response.body).to_not have_json_path("answer/#{attr}")
          end
        end
      end
    end
  end

  
  describe 'POST /questions/:question_id/answers' do
    let(:question) { create(:question) }
    let(:attributes) { attributes_for :answer }
    let(:access_token) { create(:access_token) }
    let(:params) { { answer: attributes, format: :json, access_token: access_token.token } }
    let(:post_create) { post api_v1_question_answers_path(question), params }
    
    context 'create new answer' do
	  it 'returns status created' do
		post_create
		expect(response).to be_created
	  end

	  it 'saves new answer in db' do
		expect { post_create }.to change { question.answers.count }.by(1)
	  end

      it 'answer relates to question' do
        post_create
        expect(assigns(:question)).to eq question
      end
	end
  end
end

