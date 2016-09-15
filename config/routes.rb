Rails.application.routes.draw do
  root to: 'home#index'

  constraints subdomain: 'api' do
    scope module: 'api' do
      scope module: 'v1' do # to scope prefixes of routes - should get rid of this if v2 is created 
        resources :teams, except: [:new, :edit]
        get 'teams/rank_teams_by_wins/:limit', to: 'teams#rank_teams_by_wins'
        resources :players, except: [:new, :edit] do
          resources :videos, except: [:new, :edit]
          post :create_image, on: :member
          post :concatenate_player_videos, on: :member
        end
        get 'players/top_scoring_players/:limit', to: 'players#top_scoring_players'

        resources :games, except: [:new, :edit]
        namespace :games do
          get :game_scores
        end
      end
    end
  end
end
