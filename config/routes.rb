Rails.application.routes.draw do
  root 'home#index'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  # devise_scope :user do
  #   post "/send_sms_code" => "users/sessions#send_sms_code"
  # end

  resources :posts do
    collection do
      post "/post_upload_files", to: "posts#upload"
    end
  end
  resources :brandnames
  resources :colors
end
