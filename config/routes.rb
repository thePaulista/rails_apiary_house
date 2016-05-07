Rails.application.routes.draw do
  root "todo_lists#index"

  get "login" => "user_sessions#new"
  delete "logout" => "user_sessions#destroy"

  resources :users
  resources :user_sessions, only: [:new, :create]
  resources :password_resets, only: [:new, :create, :edit, :update]

  resources :todo_lists do
    resources :todo_items do
      member do
        patch :complete
      end
    end
  end
end
