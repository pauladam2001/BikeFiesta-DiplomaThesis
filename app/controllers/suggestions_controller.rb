class SuggestionsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!, :check_permissions

  def index
    @suggestions = Suggestion.all

    if params[:solved].present?
      @suggestions = @suggestions.where(solved: params[:solved])
    else
      @suggestions = @suggestions.where(solved: false)
    end

    start_date, end_date = nil, nil
    start_date = params[:start_date].to_date.beginning_of_day if params[:start_date].present? && params[:start_date] != "all"
    end_date = params[:end_date].to_date.end_of_day if params[:end_date].present? && params[:end_date] != "all"

    @suggestions = @suggestions.where("suggestions.created_at >= ?", start_date) if params[:start_date].present? && params[:start_date] != "all"
    @suggestions = @suggestions.where("suggestions.created_at <= ?", end_date) if params[:end_date].present? && params[:end_date] != "all"

    @suggestions = @suggestions.paginate(page: params[:page], per_page: 12)
  end

  def solve
    suggestion = Suggestion.find(params[:id])
    suggestion.solved = true
    suggestion.save

    Notification.create(type: "suggestion", notified_id: suggestion.user_id, message: "Your suggestion has been seen. Thank you")

    redirect_back(fallback_location: suggestions_path)
  end

  private
    def check_permissions
      redirect_to posts_path and return if current_user.is_normal?
    end
end
