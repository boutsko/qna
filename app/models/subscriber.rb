class Subscriber < ActiveRecord::Base
  belongs_to :user
  belongs_to :question

  validates :user_id, uniqueness: { scope: :question_id }


  scope :to_questions_digest_not_sent_after, ->(date) { where(question_id: nil).
         where("coalesce(sent_at, '1970-01-01') < :date", date: date)  }
end
