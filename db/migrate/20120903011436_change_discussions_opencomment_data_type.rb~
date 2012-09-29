class ChangeDiscussionsOpencommentDataType < ActiveRecord::Migration
  def up
    remove_index :discussions, [:forum_id, :subforum_id, :updated_at]
    change_column(:discussions, :opencomment, :text, limit: nil)
  end

  def down
    add_index :discussions, [:forum_id, :subforum_id, :updated_at]
    change_column(:discussions, :opencomment, :string)
  end
end
