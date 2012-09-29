class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.string :name
      t.string :state
      t.string :lat
      t.string :lon

      t.timestamps
    end
  end
end
