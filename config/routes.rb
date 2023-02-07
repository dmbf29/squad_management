Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :teams, only: [:index] do
    resources :squads, only: [:new]
  end
  resources :squads, only: [:show] do
    member do
      post :import
    end
  end
end
