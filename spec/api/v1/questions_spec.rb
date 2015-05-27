require 'rails_helper'

describe 'Questions API' do
  describe 'GET /questions' do
    context 'unauthorized' do
      let!(:question) { create :question }
      
      it 'returns 401 status if there is no access_token' do
        get api_v1_questions_path, format: :json
        expect(response.status).to eq 401
      end

      it 'returns 401 status if access_token is invalid ' do
        get api_v1_questions_path, format: :json, access_token: '1234'
        expect(response.status).to eq 401
      end
    end

    context 'authorized' do
      let(:path_resource) { "questions/0" }
      let(:access_token) { create(:access_token) }
      let(:questions) { create_list(:question, 2) }
      let!(:question) { questions.first }
      let!(:answers) { create_list(:answer, 2, question: question) }
      let!(:resource) { question } 
      let!(:comments) { create_list(:comment, 3, commentable: resource) }
      let!(:attachments) { create_list(:attachment, 1, attachable: question) }

      before { get api_v1_questions_path, format: :json, access_token: access_token.token }
      
      it 'returns 200 status code' do
        expect(response).to be_success
      end

      it 'returns list of questions' do
        expect(response.body).to have_json_size(questions.size).at_path("questions")
      end

      resource_attributes(:question).each do |attr|
        it "contains #{ attr }" do
          resource_attr = resource.send(attr.to_sym).to_json
          path = "#{ path_resource }/#{ attr }"
          expect(response.body).to be_json_eql(resource_attr).at_path(path)
        end
      end

      resource_associations(:question).each do |association|
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


    describe 'POST /questions' do
      let(:attributes) { attributes_for :question }
      let(:access_token) { create(:access_token) }
      let(:params) { { question: attributes, format: :json, access_token: access_token.token } }
      let(:post_create) { post api_v1_questions_path, params }
      
      context 'create new question' do
		it 'returns status created' do
		  post_create
		  expect(response).to be_created
		end

		it 'saves new question in db' do
		  expect { post_create }.to change { Question.count }.by(1)
		end

        it 'relates to user' do
          post_create
          expect(response.body).to be_json_eql(access_token.resource_owner_id).at_path("question/user_id")
        end
	  end
    end
  end

end
