class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!
  
  def index
  end

  def followers_following_page

  end
end
