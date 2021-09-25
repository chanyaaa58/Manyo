class ChangeDataDeadlineToTasks < ActiveRecord::Migration[6.0]
  def up
    change_column :tasks, :deadline, :datetime
  end
end
