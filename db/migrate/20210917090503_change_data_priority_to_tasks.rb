class ChangeDataPriorityToTasks < ActiveRecord::Migration[6.0]
  def change
    change_column :tasks, :priority, :string
  end
end
