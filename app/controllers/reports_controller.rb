class ReportsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!, :check_permissions

  def index
    @reports = Report.all

    if params[:solved].present?
      @reports = @reports.where(solved: params[:solved])
    else
      @reports = @reports.where(solved: false)
    end

    start_date, end_date = nil, nil
    start_date = params[:start_date].to_date.beginning_of_day if params[:start_date].present? && params[:start_date] != "all"
    end_date = params[:end_date].to_date.end_of_day if params[:end_date].present? && params[:end_date] != "all"

    @reports = @reports.where("reports.created_at >= ?", start_date) if params[:start_date].present? && params[:start_date] != "all"
    @reports = @reports.where("reports.created_at <= ?", end_date) if params[:end_date].present? && params[:end_date] != "all"

    @reports = @reports.paginate(page: params[:page], per_page: 12)
  end

  def solve
    report = Report.find(params[:id])
    report.solved = true
    report.save
    redirect_back(fallback_location: reports_path)
  end

  private
    def check_permissions
      redirect_to posts_path and return if current_user.is_normal?
    end
end
