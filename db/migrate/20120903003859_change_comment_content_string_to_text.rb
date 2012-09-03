class ChangeCommentContentStringToText < ActiveRecord::Migration
  def up
    change_column(:comments, :content, :text, limit: nil)
  end

  def down
    change_column(:comments, :content, :string)
  end
end
