# == Schema Information
#
# Table name: games
#
#  id                    :integer          not null, primary key
#  away_team_id          :integer          not null
#  home_team_id          :integer          not null
#  winner_team_id        :integer
#  winner_teams_count    :integer          default(0)
#  start_at              :datetime
#  end_at                :datetime
#  final_home_team_score :integer
#  final_away_team_score :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

class Game < ActiveRecord::Base
  has_many :player_games
  has_many :players, through: :player_games
  belongs_to :home_team, class_name: 'Team', foreign_key: :home_team_id
  belongs_to :away_team, class_name: 'Team', foreign_key: :away_team_id
  belongs_to :winner_team, class_name: 'Team', foreign_key: :winner_team_id, counter_cache: :win_count

  validate :home_team_and_away_team_unique

  scope :ended_games, -> { where.not(end_at: nil) }
  scope :active_games, -> { where('end_at IS NULL AND start_at <= ?', Time.zone.now) }
  scope :future_games, -> { where('start_at > ?', Time.zone.now) }

  def home_team_and_away_team_unique
    home_team_id != away_team_id
  end

  def home_team_players
    home_team.players
  end

  def away_team_players
    away_team.players
  end

  def home_team_name
    home_team.name
  end

  def away_team_name
    away_team.name
  end

  # calculate home team score based on player games. scores become finalized
  # and stored once `self.end!` is called
  def home_team_score
    PlayerGame.where(game: id, player: home_team_players.pluck(:id)).sum(:score)
  end

  def away_team_score
    PlayerGame.where(game: id, player: away_team_players.pluck(:id)).sum(:score)
  end
  
  # Get a list of games with their scores
  def self.game_scores_as_json
    includes(:home_team, :away_team).as_json(
      only: [:final_home_team_score, :final_away_team_score],
      methods: [:home_team_name, :away_team_name]
    )
  end

  def ended?
    end_at.present?
  end

  def start!
    update(start_at: Time.zone.now)
  end

  # method to finalize game and store calculated values for performant queries on
  # game stats
  def end!
    update(
      end_at: Time.zone.now,
      final_home_team_score: home_team_score,
      final_away_team_score: away_team_score,
      winner_team: set_winner
    )
  end

  private

    # returns nil if tie or game hasn't ended
  def set_winner
    if home_team_score > away_team_score
      home_team
    elsif home_team_score < away_team_score
      away_team
    end
  end

end
