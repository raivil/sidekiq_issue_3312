class SubModel < ActiveRecord::Base
  belongs_to :model
  attr_accessible :name
  RETAINED = []
  def processing_task
    100_000.times do
      RETAINED << "a string with some random value #{SecureRandom.hex(30)}"
    end
    sleep 10 # fake processing delay...
    raise(Exception, "Random Exception")
  end
end
