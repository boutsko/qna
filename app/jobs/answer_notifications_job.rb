class AnswerNotificationsJob < ActiveJob::Base
  queue_as :default

  def perform(answer_id)
    answer = Answer.find(answer_id)
    subscriber = Subscriber.where(question_id: answer.question_id).find_each do |subscriber|
      SendSubs.send_subs_answer(subscriber).deliver_later
    end
  end
end
