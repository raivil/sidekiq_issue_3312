class Model < ActiveRecord::Base
  attr_accessible :name

  has_many :sub_models
end
