class Jobs::Temp::ExampleLongBatchJob
  include Sidekiq::Worker

  sidekiq_options queue: :default, unique_for: 1.hour

  def perform(number_of_subjobs)
    batch = Sidekiq::Batch.new
    batch.description = "#{self.class.name} - #{number_of_subjobs}"
    batch.on(:success, self.class, "model_id" => number_of_subjobs)
    batch.jobs do
      1.upto(number_of_subjobs).each do |i|
        Jobs::Temp::ExampleLongSubJob.perform_async(number_of_subjobs, i)
      end
    end
  end

  def on_success(_status, options)
    Rails.logger.info("Long job batch processing done!")
  end
end
