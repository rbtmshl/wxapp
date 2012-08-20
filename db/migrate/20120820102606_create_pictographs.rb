class CreatePictographs < ActiveRecord::Migration
  def change
    create_table :pictographs do |t|
      t.string :name
      t.string :description
      t.integer :user_id
      t.integer :gallery_id

      t.timestamps
    end
    add_index :pictographs, [:user_id, :created_at]
    add_index :pictographs, [:gallery_id, :created_at]
  end
end
