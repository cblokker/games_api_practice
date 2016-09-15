class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.attachment :attachment
      t.references :player, foreign_key: true, index: true, null: false
      t.timestamps null: false
    end
  end
end
