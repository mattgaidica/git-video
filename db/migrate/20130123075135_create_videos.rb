class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :commit_sha
      t.string :nimbb_guid

      t.timestamps
    end
  end
end
