class DailyDigestWorker
  include Sidekiq::Worker
  include Sidekiq::Schedulable

  recurrence { daily(1) }

  def perform
    User.send_daily_digest
  end
end
