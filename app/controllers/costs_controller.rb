class CostsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!, :check_permissions

  def index
    @costs = Cost.all

    @costs = @costs.where("description ilike ?", "%#{params[:description]}%") if params[:description].present?

    start_date, end_date = nil, nil
    start_date = params[:start_date].to_date.beginning_of_day if params[:start_date].present? && params[:start_date] != "all"
    end_date = params[:end_date].to_date.end_of_day if params[:end_date].present? && params[:end_date] != "all"

    @costs = @costs.where("costs.created_at >= ?", start_date) if params[:start_date].present? && params[:start_date] != "all"
    @costs = @costs.where("costs.created_at <= ?", end_date) if params[:end_date].present? && params[:end_date] != "all"

    @costs = @costs.paginate(page: params[:page], per_page: 12)
  end

  def new
    @cost = Cost.new
  end

  def edit
    @cost = Cost.find(params[:id])
    render :new
  end

  def update
    @cost = Cost.find(params[:id])
    @cost.attributes = cost_params
    if @cost.save
      redirect_to costs_path, alert: "Cost updated successfully."
    else
      redirect_back(fallback_location: costs_path, alert: "Error - #{@cost.errors.full_messages.first}.")
    end
  end

  def create
    @cost = Cost.new(cost_params)
    if @cost.save
      redirect_to costs_path, alert: "Cost created successfully."
    else
      redirect_back(fallback_location: costs_path, alert: "Error - #{@cost.errors.full_messages.first}.")
    end
  end

  def destroy
    @cost = Cost.find(params[:id])
    @cost.destroy
    redirect_back(fallback_location: costs_path, alert: "Cost deleted successfully.")
  end

  private
    def cost_params
      params.require(:cost).permit(:id, :description, :amount, :day)
    end

    def check_permissions
      redirect_to posts_path and return if current_user.is_normal?
    end
end
