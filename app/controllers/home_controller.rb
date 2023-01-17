class HomeController < ApplicationController
  def index
    if !current_user.present?
      redirect_to new_user_session_path and return
    else
      if current_user.is_normal?
        redirect_to posts_path and return
      else
        #TODO
      end
    end
  end
end
