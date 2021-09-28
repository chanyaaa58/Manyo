class ChangeColumnToNull < ActiveRecord::Migration[6.0]
  def up
    change_column_null :tasks, :user_id, null: true
  end

  def down
    change_column_null :tasks, :user_id, false
  end
end
