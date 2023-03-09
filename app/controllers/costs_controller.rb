class CostsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!, :check_permissions

  def index
    @costs = Cost.all

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
      redirect_to costs_path
    end
  end

  def create
    @cost = Cost.new(cost_params)
    if @cost.save
      redirect_to costs_path
    end
  end

  def destroy
    @cost = Cost.find(params[:id])
    @cost.destroy
    redirect_to costs_path
  end

  private
    def cost_params
      params.require(:cost).permit(:id, :description, :amount, :day)
    end

    def check_permissions
      redirect_to posts_path and return if current_user.is_normal?
    end
end
