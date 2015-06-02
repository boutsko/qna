# coding: utf-8
require 'rails_helper'

describe Question, type: :model do

  subject { build(:question) }

  it { should validate_presence_of :title and :body }
  it { should validate_presence_of :user }
  it { should have_many(:answers).dependent(:destroy) }
  it { should have_many :votes }
  it { should belong_to(:user) }

  it_should_behave_like "attachable"

  describe 'reputation' do
    let(:user) { create(:user) }
    subject { build(:question, user: user) }
    
    it 'should calculate reputation after creation' do
      expect(Reputation).to receive(:calculate).with(subject)
      subject.save!
    end

    it 'should not calculate receive after update' do
      subject.save!
      expect(Reputation).to receive(:calculate)
      subject.update(title: '123')
    end

    it 'should save user reputation' do
      allow(Reputation).to receive(:calculate) {5}
      # allow(Reputation).to receive(:calculate).and_return(5)
      expect { subject.save! }.to change(user, :reputation).by(5)
    end

    it 'test time' do
      now = Time.now.utc
      allow(Time).to receive(:now) { now }
#      allow(subject).to receive(:body) # can stub any object or method
      subject.save!
      expect(subject.created_at).to eq now
    end
    
    it 'test double' do
      question = double(Question, title: '123')
      allow(Question).to receive(:find) { question }
      expect(Question.find(1).title).to eq '123'
    end
  end
end
