require 'test_helper'

class Api::V1::TeamsControllerTest < ActionController::TestCase
  setup do
    @team = teams(:home_team)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:teams)
  end

  test "should create team" do
    assert_difference('Team.count') do
      post :create, team: { name: @team.name }
    end

    assert_response 201
  end

  test "should show team" do
    get :show, id: @team
    assert_response :success
  end

  test "should update team" do
    put :update, id: @team, team: { name: @team.name }
    assert_response 204
  end

  test "should destroy team" do
    assert_difference('Team.count', -1) do
      delete :destroy, id: @team
    end

    assert_response 204
  end

  test "should rank teams by wins" do
    get :rank_teams_by_wins, limit: 12
    assert_response :success
  end
  
end
