# coding: utf-8
require 'rails_helper'

RSpec.describe Question, type: :model do
  it { should validate_presence_of :title }
  it { should validate_presence_of :body }
  it { should have_many :answers }


  #  RSpec.describe Question, type: :model do
  # -  pending "add some examples to (or delete) #{__FILE__}"
  # +  it 'validates presence of title' do
  # +    expect(Question.new(body: '123')).to_not be_valid
  # +  end
  # +
  # +  it 'validates presence of body' do
  # +    expect(Question.new(title: '123')).to_not be_valid
  # +  end
  #  end


  # role = FactoryGirl.create(:role, name: “Head Buster”)
  # user = FactoryGirl.create(:user, role: role)

  describe "destroy question" do
    it "should destroy question and its answers" do
      question = FactoryGirl.create(:question, title: 'foo', body: 'bar')
      answer = FactoryGirl.create(:answer, body: 'baz', question: question)

      expect { question.destroy! }.to change{ Answer.count }.by(-1)


      # expec    question.destroy
      #     #  expect(Answer.find_by(:body 'baz')).to_not be_valid
      #     expect(Answer.all.count).to be 10
    end
  end
end
  #answer.id
  #user = FactoryGirl.create(:user, role: role)
