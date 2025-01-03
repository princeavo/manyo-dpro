class CreateLabelsTasksJoinTable < ActiveRecord::Migration[6.1]
  def change
    create_join_table :labels, :tasks do |t|
      t.index :label_id
      t.index :task_id
    end
  end
end
