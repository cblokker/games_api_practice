# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



# create some players
100.times do |i|
  Player.create(name: "#bob #{i}")
end


# create some teams
10.times do |i|
  Team.create(name: "Giants-#{i}")
end

# assign players to teams
i = 1
Player.find_each do |player|
  i += 1 if (player.id % 10 == 0)
  PlayerTeam.create(player: player, team_id: i) # player team might be redundant - what if same player is on both teams!
end

# create historical games
300.times do |i|
  home_team = Team.find(rand(1..10))
  home_team_players = home_team.players
  away_team = Team.find(rand(*[1..10] - [home_team.id]))
  away_team_players = away_team.players
  game = Game.create(home_team: home_team, away_team: away_team)
  game.start!
  puts "starting game"

  home_team_players.each do |player|
    PlayerGame.create(player: player, game: game, score: rand(1..5))
  end

  away_team_players.each do |player|
    PlayerGame.create(player: player, game: game, score: rand(1..5))
  end

  puts "ending game"
  
  game.end!
end


@players = Player.where(id: [1,2,3,4,5,6,7,8])
@file = Rack::Test::UploadedFile.new(
  File.join(Rails.root.join('test/videos/test_video.mp4')),
  'video/mp4'
)


@players.each do |player|
  3.times { Video.create(attachment: @file, player: player) }
end