class StatsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!, :check_permissions

  def index
  end

  private
    def check_permissions
      redirect_to posts_path and return if current_user.is_normal?
    end
end
