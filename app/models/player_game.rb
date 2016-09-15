# == Schema Information
#
# Table name: player_games
#
#  id         :integer          not null, primary key
#  game_id    :integer          not null
#  player_id  :integer          not null
#  score      :integer          default(0)
#  start_time :datetime
#  end_time   :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PlayerGame < ActiveRecord::Base
  belongs_to :game
  belongs_to :player
end
