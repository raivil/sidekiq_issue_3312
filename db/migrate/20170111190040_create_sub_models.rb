class CreateSubModels < ActiveRecord::Migration
  def change
    create_table :sub_models do |t|
      t.text :name
      t.references :model

      t.timestamps
    end
    add_index :sub_models, :model_id
  end
end
