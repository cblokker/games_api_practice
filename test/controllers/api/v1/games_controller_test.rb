require 'test_helper'

class Api::V1::GamesControllerTest < ActionController::TestCase
  setup do
    @game = games(:game_one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:games)
  end

  test "should create game" do
    assert_difference('Game.count') do
      post :create, game: { home_team_id: @game.home_team, away_team_id: @game.away_team }
    end

    assert_response 201
  end

  test "should show game" do
    get :show, id: @game
    assert_response :success
  end

  test "should update game" do
    put :update, id: @game, game: { home_team: @game.home_team, away_team: @game.away_team }
    assert_response 204
  end

  test "should destroy game" do
    assert_difference('Game.count', -1) do
      delete :destroy, id: @game
    end

    assert_response 204
  end

  test "should return game scores" do
    get :game_scores
    assert_response :success
  end
end
