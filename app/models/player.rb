# == Schema Information
#
# Table name: players
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Player < ActiveRecord::Base
  has_many :player_teams
  has_many :teams, through: :player_teams
  has_many :player_games
  has_many :games, through: :player_games
  has_many :videos

  scope :top_scoring_players, -> (limit = 10) {
    joins(:player_games)
    .group(:player_id)
    .order("sum(player_games.score) DESC")
    .limit(limit)
  }

  # ideally store these videos in S3, not locally
  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" },
    default_url: "/images/:style/missing.png"

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  def current_teams
    last_team = teams.last
    last_team.present? ? last_team : 'Not actively a part of a team'
  end

  ### Player stats for total games played (no concept of seasons in schema :/) ###

  def score_total
    PlayerGame.where(player_id: id).sum(:score)
  end

  def score_average_per_game
    PlayerGame.where(player_id: id).average(:score).to_i
  end

  # NOT WORKING - but it's the general approach
  # also - MAKE IDEMPOTENT
  def concatenate_videos
    begin
      output_video = Video.new(player: self)
      concat_string = "ffmpeg -i \"concat:"
      videos.each do |video|
        file_url = File.join(Rails.root, 'public', video.attachment.url(:original, false))
        concat_string << file_url + " | "
      end

      system "#{concat_string[0..-3]}\" -c copy #{output_video.attachment}"
      # Video.create(attachment: output_video, player: self)
      output_video.save!
    rescue StandardError => error
      raise error
    end
  end

end
