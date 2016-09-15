class CreatePlayerTeams < ActiveRecord::Migration
  def change
    create_table :player_teams do |t|
      t.references :team, foreign_key: true, index: true, null: false
      t.references :player, foreign_key: true, index: true, null: false

      t.timestamps null: false
    end
  end
end
