require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { should belong_to :question }
  it { should belong_to :user }
  it { should have_many :votes }

  it { should validate_presence_of :body }

  it_should_behave_like "attachable"
  it_should_behave_like "commentable"
    
  describe "#make_best" do
    let(:question) { create(:question) }
    let!(:answer) { create(:answer, question: question, best: true) }
    let!(:other_answer) { create(:answer, question: question) }

    it "should mark answer as best" do
      expect(other_answer.best).to_not eq true

      other_answer.make_best

      expect(other_answer.best).to eq true
    end

    it "should have only one best answer" do
      other_answer.make_best
      answer.reload

      expect(answer.best).to_not eq true
      expect(other_answer.best).to eq true
    end
  end
end
