class CreateStations < ActiveRecord::Migration
  def change
    create_table :stations do |t|
      t.string :identifier
      t.string :city
      t.string :state
      t.string :lat
      t.string :lon

      t.timestamps
    end
  end
end
