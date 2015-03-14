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

  describe 'GET #show' do
    before { get :show, id: answer, question_id: question }
    
    it 'assigns requested answer to @answer' do
      expect(assigns(:answer)).to eq answer
    end
    
    it 'renders show view' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    before { get :new, question_id: question }
    
    it 'assigns new Answer to @answer ' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    before { get :edit, id: answer, question_id: question }

    it 'assigns requested answer to @answer' do
      expect(assigns(:answer)).to eq answer
    end

    it 'renders edit view' do
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves new answer in database'do
        expect { post :create, answer: build_attributes(:answer), question_id: question }.to change(question.answers, :count).by(1)
      end
      it 'redirects to show view' do
        post :create, answer: build_attributes(:answer), question_id: question
        expect(response).to redirect_to question_answer_path(assigns(:question), assigns(:answer))
      end
    end

    context 'with invalid attributes' do
      it 'does not save the answer' do
        expect { post :create, answer: build_attributes(:invalid_answer), question_id: question }.to_not change(question.answers, :count)
      end

      it 're-renders new view' do
        post :create, answer: build_attributes(:invalid_answer), question_id: question
        expect(response).to render_template :new
      end
    end
  end

end
