class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title
      t.references :project, index:true
      t.integer :priority
      t.datetime :dedline
      t.boolean :complete

      t.timestamps
    end
    add_index :tasks, [:project_id, :created_at]
  end
end
