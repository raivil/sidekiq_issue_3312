class Jobs::BatchJob
  include Sidekiq::Worker

  sidekiq_options queue: :default, unique_for: 1.hour

  def perform(id)
    model = ::Model.find(id)
    batch = Sidekiq::Batch.new
    batch.description = "#{self.class.name}"
    batch.on(:success, self.class, "model_id" => id)
    batch.jobs do
      model.sub_models.each do |sub_model|
        Jobs::SubJob.perform_async(sub_model.id)
      end
    end
  end

  def on_success(_status, options)
    puts "Model processing done!"
  end
end
