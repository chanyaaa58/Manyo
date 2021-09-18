class ChangeDataDeadlineToTasks < ActiveRecord::Migration[6.0]
  def change
    change_column :tasks, :deadline, :datetime
  end
end
