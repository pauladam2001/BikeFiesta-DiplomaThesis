class HomeController < ApplicationController
  def index
    if !current_user.present?
      redirect_to new_user_session_path and return
    else
      redirect_to posts_path and return
    end
  end
end
