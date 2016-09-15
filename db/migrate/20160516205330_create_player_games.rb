class CreatePlayerGames < ActiveRecord::Migration
  def change
    create_table :player_games do |t|
      t.references :game, foreign_key: true, index: true, null: false
      t.references :player, foreign_key: true, index: true, null: false
      t.integer :score, default: 0, null: false

      t.timestamps null: false
    end
  end
end
