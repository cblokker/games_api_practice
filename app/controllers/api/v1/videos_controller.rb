class Api::V1::VideosController < ApplicationController
  before_action :set_player
  # before_action :set_video, only: [:show, :update, :destroy]

  def index
    @videos = @player.videos
    render json: @videos
  end

  def show
    @video = @player.videos.find(params[:id])
    render json: @video
  end

  def create
    @video = @player.videos.new(video_params)

    if @video.save
      render json: @video, status: :created, location: player_video_url(@player, @video)
    else
      render json: @video.errors, status: :unprocessable_entity
    end
  end

  def update
    @video = @player.videos.find(params[:id])

    if @video.update(video_params)
      head :no_content
    else
      render json: @video.errors, status: :unprocessable_entity
    end
  end


  def destroy
    @video = @player.videos.find(params[:id])
    @video.destroy
    head :no_content
  end

  private

  def set_player
    @player = Player.find(params[:player_id])
  end

  def video_params
    params.require(:video).permit(:attachment)
  end
end