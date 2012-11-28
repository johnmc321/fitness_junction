class AddUserIdToActivity < ActiveRecord::Migration
  def change
  	add_column :activities, :user_id, :integer
  	add_index :activities, [:user_id, :created_at]
  end
end
