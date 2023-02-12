class ApplicationController < ActionController::Base
  before_action :set_notifications

  def set_notifications
    if current_user.present? && current_user.is_normal?
      @notifications = current_user&.notifications
      @notifications_number = @notifications.size rescue 0
    end
  end
end
