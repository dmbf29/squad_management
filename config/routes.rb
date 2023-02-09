Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :teams, only: [:index] do
    resources :squads, only: [:new]
  end
  resources :squads, only: [:show] do
    member do
      post :import
      delete :empty
    end
  end
  resources :spots, only: [:update] do
    member do
      patch :update_places
    end
  end
  resources :players, only: [:update] do
    resources :player_tags, only: [:create]
  end
  resources :player_tags, only: [:destroy]
end
