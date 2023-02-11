class ApplicationController < ActionController::Base
  before_action :set_notifications

  def set_notifications
    @notifications = current_user.notifications
    @notifications_number = @notifications.size
  end
end
