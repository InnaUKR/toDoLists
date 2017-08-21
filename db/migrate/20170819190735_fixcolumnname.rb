class Fixcolumnname < ActiveRecord::Migration
  def change
    rename_column :tasks, :dedline, :deadline
  end
end
