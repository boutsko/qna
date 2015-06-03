require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let!(:question) { create(:question, user: user) }
  let(:answer) { create(:answer, question: question, user: user) }
  let(:answers) { create_list(:answer, 2, question: question, user: user) }

  let(:attributes) { build_attributes :answer }
  let(:post_answer) { post :create, answer: attributes, question_id: question, format: :js }
  let(:post_invalid) { post :create, answer: invalid_attr, question_id: question, format: :js }
  let(:publish_channel) { "/questions/#{ question.id }" }


  describe 'POST #create PrivatePub publish' do

    sign_in_user

    context 'with valid attributes' do

      let(:do_request) { post_answer }
      it "publishes to given channel for subscribers" do
        # post :create, answer: attributes, question_id: question, format: :js
        # expect(PrivatePub).to receive(:publish_to).with(publish_channel, anything)

        expect(PrivatePub).to receive(:publish_to).with("/questions/#{ question.id }", anything)
        # expect(PrivatePub).to receive(:publish_to)
        # allow(PrivatePub).to receive(:publish_to) {anythinng}

        # binding.pry

        # post :create, answer: attributes, question_id: question, format: :js
        # binding.pry
        # post :create, answer: build_attributes(:answer), question_id: question, format: :js

        # PrivatePub.publish_to("/questions/#{ question.id }", "helloWorld")

        do_request
      end


      # it_behaves_like "publishable"
    end
  end


  describe 'GET #edit' do
    sign_in_user
    before { get :edit, id: answer, question_id: question }

    it 'assigns requested answer to @answer' do
      expect(assigns(:answer)).to eq answer
    end
  end

  describe 'POST #create' do

    sign_in_user

    context 'with valid attributes' do
      it 'saves new answer in database'do
        expect { post :create, answer: build_attributes(:answer), question_id: question, format: :js }.to change(question.answers, :count).by(1)
      end
      it 'render create template' do
        post :create, answer: build_attributes(:answer), question_id: question, format: :js
        expect(response).to render_template :create
      end
      it 'expects the answer belongs to the user' do
        post :create, answer: build_attributes(:answer), question_id: question, format: :js
        expect(assigns(:answer).user).to eq subject.current_user
      end

    end

    context 'with invalid attributes' do

      before { answer; question }

      it 'does not save the answer' do
        expect { post :create, answer: build_attributes(:invalid_answer), question_id: question }.to_not change(Answer, :count)
      end

    end
  end

  describe 'PATCH #update' do

    before { sign_in answer.user }

    context 'valid attributes' do
      it 'assigns the requested answer to @answer' do
        patch :update, id: answer, answer: build_attributes(:answer), question_id: question, format: :js
        expect(assigns(:answer)).to eq answer
      end

      it 'changes answer attributes' do
        patch :update, id: answer, answer: { body: 'new body' }, question_id: question, format: :js
        answer.reload
        expect(answer.body).to eq 'new body'
      end

      it 'renders update template' do
        patch :update, id: answer, answer: build_attributes(:answer), question_id: question, format: :js
        expect(response).to render_template :update
      end

      it 'assigns the question' do
        patch :update, id: answer, answer: build_attributes(:answer), question_id: question, format: :js
        expect(assigns(:question)).to eq question
      end
    end

    context 'invalid attributes' do
      before { patch :update, id: answer, format: :js, answer: { body: nil }, question_id: question }

      it 'does not change answer attributes' do
        answer.reload
        expect(answer.body).to eq 'AnswerBody'
      end
    end
  end

  describe 'PATCH #best' do

    before { sign_in question.user }

    context 'Question\'s author' do

      it 'changes answer to be the best one' do
        patch :best, id: answer, question_id: question, format: :js
        answer.reload
        expect(answer.best).to be true
      end
    end
  end

  describe 'PATCH #best' do

    before { sign_in other_user }

    context 'Non author of the Question' do

      it 'tries to change answer to be the best one' do
        patch :best, id: answer, question_id: question, format: :js
        answer.reload
        expect(answer.best).to_not be true
      end
    end
  end

  describe 'DELETE #destroy' do

    before { sign_in answer.user }
    before { question; answer  }

    it 'author deletes answer' do
      expect { delete :destroy , id: answer, format: :js, question_id: question }.to change(Answer, :count).by(-1)
    end

    it 'other user tries to delete answer' do
      answer1 = Answer.create(
        body: 'Answer of other user',
        question: question,
        user: other_user)

      expect { delete :destroy , id: answer1, question_id: question, format: :js }.to_not change(Answer, :count)
    end

    it 'render destroy template' do
      delete :destroy, id: answer, format: :js, question_id: question
      expect(response).to render_template :destroy
    end
  end
end
