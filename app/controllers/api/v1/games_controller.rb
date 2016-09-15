module Api::V1
  class GamesController < ApplicationController
    before_action :set_game, only: [:show, :update, :destroy]

    def index
      @games = Game.all
      render json: @games
    end

    def show
      render json: @game
    end

    def create
      @game = Game.new(game_params)

      if @game.save
        render json: @game, status: :created, location: @game
      else
        render json: @game.errors, status: :unprocessable_entity
      end
    end

    def update
      if @game.update(game_params)
        head :no_content
      else
        render json: @game.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @game.destroy
      head :no_content
    end

    def game_scores
      @games = Game.game_scores_as_json
      render json: @games
    end

    private

    def set_game
      @game = Game.find(params[:id])
    end

    def game_params
      params.require(:game).permit(:home_team_id, :away_team_id, :start_at)
    end
  end
end
