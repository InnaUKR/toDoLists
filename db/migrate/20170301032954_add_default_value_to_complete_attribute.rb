class AddDefaultValueToCompleteAttribute < ActiveRecord::Migration
  def change
  	change_column :tasks, :complete, false
  end
end
