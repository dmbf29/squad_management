Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :teams, only: [:index]
  resources :squads, only: [:show] do
    member do
      get :import
      post :import_players
    end
  end
end
