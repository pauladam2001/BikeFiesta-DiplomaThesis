class HomeController < ApplicationController
  def index
    if !current_user.present?
      redirect_to new_user_session_path and return
    else
      session[:current_user] = current_user.id
      if current_user.is_normal?
        redirect_to posts_path and return
      else
        redirect_to users_path and return
      end
    end
  end
end
