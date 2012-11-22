class AddAttachmentUploadToActivities < ActiveRecord::Migration
  def self.up
    change_table :activities do |t|
      t.has_attached_file :upload
    end
  end

  def self.down
    drop_attached_file :activities, :upload
  end
end
