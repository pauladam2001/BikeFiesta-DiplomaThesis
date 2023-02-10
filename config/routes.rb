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
    
    member do
      put :add_to_favorites
      put :remove_from_favorites
    end
  end

  get "/my_posts", to: "posts#my_posts"
  get "/most_viewed_posts", to: "posts#most_viewed_posts"
  get "/on_sale_posts", to: "posts#on_sale_posts"
  get "/following_posts", to: "posts#following_posts"
  get "/all_posts", to: "posts#all_posts"
  get "favorites", to: "posts#favorites"

  resources :brandnames
  resources :colors
  resources :categories
  resources :materials
  resources :component_groups

  resources :relationships, only: [:create, :destroy]

  resources :users do
    member do
      put :archive_user
      put :unarchive_user
      put :make_user_admin
      put :remove_user_admin
    end
  end

  get "/follow_page", to: "users#follow_page"

  get '*path' => redirect('/posts')
end
