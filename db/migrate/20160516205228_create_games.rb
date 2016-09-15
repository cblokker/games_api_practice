class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.references :away_team, references: :teams, foreign_key: true, index: true, null: false
      t.references :home_team, references: :teams, foreign_key: true, index: true, null: false
      t.references :winner_team, references: :teams, foreign_key: true, index: true
      t.datetime :start_at
      t.datetime :end_at
      t.integer :final_home_team_score
      t.integer :final_away_team_score

      t.timestamps null: false
    end
  end
end