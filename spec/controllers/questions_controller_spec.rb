require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do

  let!(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:question) { create(:question, user: user) }
  let(:question_from_other_user) { create(:question, user: other_user) }
  let(:questions) { create_list(:question, 2, user: user) }
  
  describe 'GET #index' do

    before { get :index }
    before { questions }
    
    it 'populates array of all questions' do
      expect(assigns(:questions)).to match_array(questions)
    end
    
    it 'renders index view' do
      expect(response).to render_template :index
    end
    
  end

  describe 'GET #show' do
    before { get :show, id: question }
    
    it 'assigns requested question to @question' do
      expect(assigns(:question)).to eq question
    end

    it 'assignes new answer for question' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    sign_in_user

    before { get :new }
    
    it 'assigns new Question to @question ' do
      expect(assigns(:question)).to be_a_new(Question)
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    sign_in_user
    before { get :edit, id: question }

    it 'assigns requested question to @question' do
      expect(assigns(:question)).to eq question
    end
  end

  describe 'POST #create' do
    sign_in_user    

    context 'with valid attributes' do
      
      it 'saves new question in database' do
        expect { post :create, question: attributes_for(:question) }.to change(Question, :count).by(1)
      end
      
      it 'redirects to show view' do
        post :create, question: attributes_for(:question)
        expect(response).to redirect_to question_path(assigns(:question))
      end

      it 'makes sure created question is linked to the user' do
        post :create, question: { title: 'test', body: 'test' }
        expect(assigns(:question).user).to eq subject.current_user
      end
    end

    context 'with invalid attributes' do
      it 'does not save the question' do
        expect { post :create, question: attributes_for(:invalid_question) }.to_not change(Question, :count)
      end

      it 're-renders new view' do
        post :create, question: attributes_for(:invalid_question)
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do

    before { sign_in question.user }

    context 'valid attributes' do
      it 'assigns the requested question to @question' do
        patch :update, id: question, question: attributes_for(:question)
        expect(assigns(:question)).to eq question
      end

      it 'changes question attributes_for' do
        patch :update, id: question, question: { title: 'new title', body: 'new body' }
        question.reload
        expect(question.title).to eq 'new title'
        expect(question.body).to eq 'new body'
      end

      it 'redirects to the updated question' do
        patch :update, id: question, question: attributes_for(:question)
        expect(response).to redirect_to question
      end
    end

    context 'invalid attributes' do
      before { patch :update, id: question, question: { title: 'new title', body: nil } }
      it 'does not change question attributes' do

        question.reload
        expect(question.title).to eq 'QuestionTitle'
        expect(question.body).to eq 'QuestionBody'
      end

      it 're-renders edit view' do
        expect(response).to render_template :edit
      end
    end

    describe 'DELETE #destroy' do

      before { sign_in question.user }
      
      it 'deletes question' do
        expect { delete :destroy , id: question }.to change(Question, :count).by(-1)
      end

      it 'can\'t delete question of another user' do
        question_from_other_user 
        expect { delete :destroy , id: question_from_other_user }.to_not change(Question, :count)
      end
      
      it 'redirect to index view' do
        delete :destroy, id: question
        expect(response).to redirect_to questions_path
      end
    end
  end
end
