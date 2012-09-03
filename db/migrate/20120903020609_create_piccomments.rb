class CreatePiccomments < ActiveRecord::Migration
  def change
    create_table :piccomments do |t|
      t.string :content
      t.integer :user_id
      t.integer :pictograph_id

      t.timestamps
    end
  end
end
