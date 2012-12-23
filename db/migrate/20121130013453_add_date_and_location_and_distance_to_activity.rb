class AddDateAndLocationAndDistanceToActivity < ActiveRecord::Migration
  def change
    add_column :activities, :duration, :integer
    add_column :activities, :distance, :integer
    add_column :activities, :date, :date
  end
end
