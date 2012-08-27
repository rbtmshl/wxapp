class CreateSubforums < ActiveRecord::Migration
  def change
    create_table :subforums do |t|
      t.string :name
      t.integer :forum_id

      t.timestamps
    end
  end
end
