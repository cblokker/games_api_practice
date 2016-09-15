module Api::V1
  class PlayersController < ApplicationController
    before_action :set_player, only: [:show, :update, :destroy, :create_image,
      :concatenate_player_videos]

    def index
      @players = Player.all
      render json: @players
    end

    def show
      render json: @player
    end

    def create
      @player = Player.new(player_params)

      if @player.save
        render json: @player, status: :created, location: @player
      else
        render json: @player.errors, status: :unprocessable_entity
      end
    end

    def update
      if @player.update(player_params)
        head :no_content
      else
        render json: @player.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @player.destroy
      head :no_content
    end

    def top_scoring_players
      @players = Player.top_scoring_players(params[:limit]).as_json(methods: [:score_total])
      render json: @players
    end

    def create_image
      if @player.update(image: params[:image])
        head :no_content
      else
        render json: @player.errors, status: :unprocessable_entity
      end
    end

    def concatenate_player_videos
      if @player.concatenate_videos
        head :no_content
      else
        render json: @player.errors, status: :unprocessable_entity
      end
    end

    private

    def set_player
      @player = Player.find(params[:id])
    end

    def player_params
      params.require(:player).permit(:name)
    end
  end
end