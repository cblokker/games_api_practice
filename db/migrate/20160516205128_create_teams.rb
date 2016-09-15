class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name, null: false
      t.integer :win_count, default: 0, null: false
      t.timestamps null: false
    end
  end
end
