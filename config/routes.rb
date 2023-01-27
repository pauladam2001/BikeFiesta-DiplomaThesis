Rails.application.routes.draw do
  root 'home#index'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  resources :posts do
    collection do
      post "/post_upload_files", to: "posts#upload"
    end
  end

  get "/my_posts", to: "posts#my_posts"

  resources :brandnames
  resources :colors
  resources :categories
  resources :materials
  resources :component_groups

  # resources :relationships, only: [:create, :destroy] # do we need it? Page 871

  resources :users do
    member do
      put :archive_user
      put :unarchive_user
      put :make_user_admin
      put :remove_user_admin
    end
  end

  get "/followers", to: "users#followers_following_page"

  get '*path' => redirect('/posts')
end
