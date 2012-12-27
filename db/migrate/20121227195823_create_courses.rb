class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.integer :activity_id

      t.timestamps
    end
  end
end
