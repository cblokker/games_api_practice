# == Schema Information
#
# Table name: player_teams
#
#  id         :integer          not null, primary key
#  team_id    :integer          not null
#  player_id  :integer          not null
#  left_at    :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PlayerTeam < ActiveRecord::Base
  belongs_to :team
  belongs_to :player

  def test_challenge
    return 'update'
  end
end
