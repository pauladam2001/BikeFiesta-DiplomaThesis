class RelationshipsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!

  def create
    user = User.find(params[:followed_id]) 
    current_user.follow(user)
    redirect_back(fallback_location: posts_path)
  end

  def destroy
    user = Relationship.find(params[:id]).followed 
    current_user.unfollow(user)
    redirect_back(fallback_location: posts_path)
  end
end
