class Jobs::Temp::ExampleSubJob
  include Sidekiq::Worker
  sidekiq_options queue: :default, unique_for: 24.hours

  def perform(parent_total_jobs, id)
    prng = Random.new
    time = prng.rand(9)
    sleep time # fake processing delay...
    Rails.logger.info("Running job #{id} of #{parent_total_jobs} for #{time} seconds and failing: #{should_fail?(time)}")
    raise(Exception, "Random Exception raised 11% of time") if should_fail?(time) #fail 11% of time
  end

  private

  def should_fail?(time)
    (time % 9) == 1
  end

end
