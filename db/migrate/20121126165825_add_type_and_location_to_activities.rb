class AddTypeAndLocationToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :type, :string
    add_column :activities, :location, :string
  end
end
