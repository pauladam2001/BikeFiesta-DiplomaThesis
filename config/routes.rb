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
      post "/post_upload_proof", to: "posts#upload_proof"
    end
    
    member do
      put :add_to_favorites
      put :remove_from_favorites
      put :ban
      get :upload_proof
    end
  end

  get "/my_posts", to: "posts#my_posts"
  get "/bikes_to_ship", to: "posts#bikes_to_ship"
  get "/bought_bikes", to: "posts#bought_bikes"
  get "/most_viewed_posts", to: "posts#most_viewed_posts"
  get "/on_sale_posts", to: "posts#on_sale_posts"
  get "/following_posts", to: "posts#following_posts"
  get "/all_posts", to: "posts#all_posts"
  get "/favorites", to: "posts#favorites"
  get "/user_posts", to: "posts#user_posts"

  resources :brandnames
  resources :colors
  resources :categories
  resources :materials
  resources :component_groups
  
  resources :reports do
    member do
      put :solve
    end
  end
  
  resources :suggestions do
    member do
      put :solve
    end
  end

  resources :relationships, only: [:create, :destroy]

  resources :users do
    member do
      put :archive_user
      put :unarchive_user
      put :make_user_admin
      put :remove_user_admin
      put :showed_rules
    end
  end

  resources :reviews
  resources :notifications
  
  resources :purchases do
    member do
      put :mark_as_shipped
      put :cancel_purchase
      put :mark_on_hold
      put :mark_off_hold
    end
  end

  resources :rooms do
    resources :messages
  end

  resources :costs
  resources :stats, only: [:index]
  post "/stats", to: "stats#index"

  get "/follow_page", to: "users#follow_page"

  get "/checkout", to: "purchases#checkout"
  post "/checkout", to: "purchases#checkout"

  get "/issues", to: "issues#index"
  
  get "/leaderboard", to: "stats#leaderboard"
  post "/leaderboard", to: "stats#leaderboard"

  get '*path' => redirect('/posts')
end
