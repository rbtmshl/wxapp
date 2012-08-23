class AddImageToPictographs < ActiveRecord::Migration
  def change
    add_column :pictographs, :image, :string
  end
end
