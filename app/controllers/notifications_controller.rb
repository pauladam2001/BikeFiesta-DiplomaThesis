class NotificationsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!

  def destroy
    @notification = Notification.find(params[:id])
    @notification.destroy
    redirect_back(fallback_location: posts_path)
  end
end
