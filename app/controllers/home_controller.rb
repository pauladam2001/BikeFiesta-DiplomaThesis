class HomeController < ApplicationController
  def index
    if !current_user.present?
      redirect_to new_user_session_path and return
    else
      # redirect_to '#' and return  #TODO
    end
  end
end
