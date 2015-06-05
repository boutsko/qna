class QuestionsDigestJob < ActiveJob::Base
  queue_as :default

  def perform
    today = Time.now.utc.to_date
    body = SendSubs.questions_digest_body(today)
    return if body.blank?
    Subscriber.to_questions_digest_not_sent_after(today).find_each do |subscription|
      SendSubs.questions_digest_email(subscription.id, body).deliver_later
    end
  end
end
