class RenameFromDeadlineToExpiredAtOnTasks < ActiveRecord::Migration[6.0]
  def change
    rename_column :tasks, :deadline, :expired_at
  end
end
