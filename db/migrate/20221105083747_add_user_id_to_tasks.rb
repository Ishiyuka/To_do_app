class AddUserIdToTasks < ActiveRecord::Migration[6.1]
  def up
    execute 'DELETE FROM tasks;'
    add_reference :tasks, :user, foreign_key: true
  end

  def down
    remove_reference :tasks, :users, null:false, index:true
  end
end
