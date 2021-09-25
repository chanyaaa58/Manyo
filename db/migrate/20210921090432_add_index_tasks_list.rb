class AddIndexTasksList < ActiveRecord::Migration[6.0]
  def change
    add_index :tasks, :list
  end
end
