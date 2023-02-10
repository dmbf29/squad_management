Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :teams, only: [:index, :create] do
    resources :squads, only: [:new]
  end
  resources :squads, only: [:show] do
    member do
      post :import
      delete :empty
    end
  end
  resources :spots, only: [:create, :update] do
    member do
      patch :update_places
    end
    collection do
      patch :update_all
    end
  end
  resources :players, only: [:create, :update, :destroy] do
    resources :player_tags, only: [:create]
  end
  resources :player_tags, only: [:destroy]
end
