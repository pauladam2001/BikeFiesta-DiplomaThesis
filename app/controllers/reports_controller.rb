class ReportsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!, :check_permissions

  def index
    @reports = Report.all #TODO with filters
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
