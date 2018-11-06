Rails.application.routes.draw do
  root 'pictures#index'
  resources :pictures
  resources :pictures do
    collection do
      post :confirm
    end
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :users
  get "/users/favorites/:id" => "users#favorites"
  resources :favorites, only: [:create, :destroy]
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
