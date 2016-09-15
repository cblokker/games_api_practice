require 'test_helper'

class Api::V1::VideosControllerTest < ActionController::TestCase
  setup do
    @video = videos(:video_one)
    @player = @video.player
  end

  test "should get index" do
    get :index, player_id: @player
    assert_response :success
    assert_not_nil assigns(:videos)
  end

  test "should create video" do
    @file = Rack::Test::UploadedFile.new(
      File.join(Rails.root.join('test/videos/test_video.mp4')),
      'video/mp4')

    assert_difference('Video.count') do
      post :create, player_id: @player, video: { attachment: @file }
    end

    assert_response 201
  end

  test "should show video" do
    get :show, id: @video, player_id: @player
    assert_response :success
  end

  test "should update video" do
    @file = Rack::Test::UploadedFile.new(
      File.join(Rails.root.join('test/videos/test_video.mp4')),
      'video/mp4')
    put :update, id: @video, video: { attachment: @file }, player_id: @player
    assert_response 204
  end

  test "should destroy video" do
    assert_difference('Video.count', -1) do
      delete :destroy, id: @video, player_id: @player
    end

    assert_response 204
  end
end