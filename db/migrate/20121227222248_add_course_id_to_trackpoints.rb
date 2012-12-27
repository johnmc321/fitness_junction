class AddCourseIdToTrackpoints < ActiveRecord::Migration
  def change
    add_column :trackpoints, :course_id, :integer
  end
end
