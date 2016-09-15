# == Schema Information
#
# Table name: teams
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Team < ActiveRecord::Base
  has_many :player_teams
  has_many :players, through: :player_teams
  has_many :home_games, class_name: 'Game', foreign_key: :home_team_id
  has_many :away_games, class_name: 'Game', foreign_key: :away_team_id
  has_many :won_games, class_name: 'Game', foreign_key: :winner_team_id

  scope :rank_teams_by_wins, -> (limit = 10) {
    order('win_count DESC').limit(limit)
  }

end
