class ColorsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!, :check_permissions
  
  def index
    @colors = Color.order('name ASC')
    @colors = @colors.paginate(page: params[:page], per_page: 12)
  end

  def new
    @color = Color.new
  end

  def edit
    @color = Color.find(params[:id])
    render :new
  end
  
  def update
    @color = Color.find(params[:id])
    @color.attributes = color_params
    if @color.save
      redirect_to colors_path
    end
  end
  
  def create
    @color = Color.new(color_params)
    if @color.save
      redirect_to colors_path
    end
  end

  def destroy
    @color = Color.find(params[:id])
    @color.destroy
    redirect_to colors_path
  end

  private
    def color_params
      params.require(:color).permit(:id, :name)
    end

    def check_permissions
      redirect_to posts_path and return if current_user.is_normal?
    end
end
