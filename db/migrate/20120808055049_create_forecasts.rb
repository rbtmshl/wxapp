class CreateForecasts < ActiveRecord::Migration
  def change
    create_table :forecasts do |t|
      t.integer :user_id
      t.string :sensible
      t.integer :hi_temp
      t.integer :lo_temp
      t.integer :ws
      t.integer :wd
      t.integer :precip_chance
      t.float :qpf

      t.timestamps
    end
    add_index :forecasts, [:user_id, :created_at]
  end
end
