class ChangeDiscussionsOpencommentDataType < ActiveRecord::Migration
  def up
    change_column(:discussions, :opencomment, :text, limit: nil)
  end

  def down
    change_column(:discussions, :opencomment, :string)
  end
end
