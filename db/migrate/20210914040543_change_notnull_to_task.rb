class ChangeNotnullToTask < ActiveRecord::Migration[6.0]
  def change
    change_column_null :tasks, :list, false
    change_column_null :tasks, :detail, false
  end
end
