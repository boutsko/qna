require 'rails_helper'

RSpec.describe AnswerNotificationsJob, type: :job do


  let!(:question) { create(:question)}
  let!(:answer) { create(:answer)}
  let!(:subscriber) { create(:subscriber, question: answer.question) }

  before{ActionMailer::Base.deliveries = []}

  it 'sends notice' do
    AnswerNotificationsJob.perform_later(answer.id)

    expect(ActionMailer::Base.deliveries.count).to eq 1

  end

  it 'sends daily question digest' do
    QuestionsDigestJob.perform_later

    expect(ActionMailer::Base.deliveries.count).to eq 1

  end

  
end
