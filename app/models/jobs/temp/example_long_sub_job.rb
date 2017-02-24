class Jobs::Temp::ExampleLongSubJob
  include Sidekiq::Worker
  sidekiq_options queue: :default, unique_for: 24.hours

  def perform(parent_total_jobs, id)
    sleep(1.hour + 5.minutes)
    Rails.logger.info("Running job #{id} of #{parent_total_jobs} for 1 hour and 5 minutes")
  end
end
