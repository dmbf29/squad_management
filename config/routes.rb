Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :teams, only: [:index]
  resources :squads, only: [:show] do
    collection do
      post :import
    end
  end
end
