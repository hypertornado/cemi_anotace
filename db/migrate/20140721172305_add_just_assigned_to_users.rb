class AddJustAssignedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :just_assigned, :boolean
  end
end
