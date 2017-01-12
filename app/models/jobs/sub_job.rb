class Jobs::SubJob
  include Sidekiq::Worker
  sidekiq_options queue: :default, unique_for: 24.hours

  def perform(id)
    sub_model = SubModel.find(id)
    sub_model.processing_task
  end
end
