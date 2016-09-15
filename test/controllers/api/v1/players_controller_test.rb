require 'test_helper'

class Api::V1::PlayersControllerTest < ActionController::TestCase
  setup do
    @player = players(:player_one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:players)
  end

  test "should create player" do
    assert_difference('Player.count') do
      post :create, player: { name: @player.name }
    end

    assert_response 201
  end

  test "should show player" do
    get :show, id: @player
    assert_response :success
  end

  test "should update player" do
    put :update, id: @player, player: { name: @player.name }
    assert_response 204
  end

  test "should destroy player" do
    assert_difference('Player.count', -1) do
      delete :destroy, id: @player
    end

    assert_response 204
  end

  test "should return top scoring players" do
    get :top_scoring_players, limit: 12
    assert_response :success
  end

  test "should create image" do
    @file = Rack::Test::UploadedFile.new(
      File.join(Rails.root.join('test/photos/test_photo.jpg')),
      'image/jpeg')

    post :create_image, image: @file, id: @player

    assert_response 204
    assert_not_nil @player.image
  end

  test "should concatenate player videos " do
    assert_difference('Video.count', 1) do
      post :concatenate_player_videos, id: @player
    end
    assert_response 204
  end

end