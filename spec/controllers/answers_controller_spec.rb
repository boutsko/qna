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

end
