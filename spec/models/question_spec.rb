# coding: utf-8
require 'rails_helper'

RSpec.describe Question, type: :model do
  it { should validate_presence_of :title }
  it { should validate_presence_of :body }
  it { should have_many :answers }


  describe "destroying question" do
    it "should destroy question and all its answers" do
      question = FactoryGirl.create(:question)
      answer = FactoryGirl.create(:answer, question: question)
      answer1 = FactoryGirl.create(:answer, question: question)
      expect { question.destroy! }.to change{ Answer.count }.by(-2)
    end
  end
end
