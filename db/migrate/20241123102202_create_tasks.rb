class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :content

      t.timestamps
    end
    change_column :tasks, :title, :string, null: false
    change_column :tasks, :content, :text, null: false
  end
end
