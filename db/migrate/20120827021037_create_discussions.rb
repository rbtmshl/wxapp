class CreateDiscussions < ActiveRecord::Migration
  def change
    create_table :discussions do |t|
      t.string :opencomment
      t.string :name
      t.integer :forum_id
      t.integer :subforum_id
      t.integer :user_id

      t.timestamps
    end
    add_index :discussions, [:forum_id, :subforum_id, :updated_at]
    add_index :discussions, [:user_id, :updated_at]
  end
end
