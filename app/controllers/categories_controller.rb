class CategoriesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!, :check_permissions
  
  def index
    @categories = Category.order('name ASC')

    @categories = @categories.where("name ilike ?", "%#{params[:name]}%") if params[:name].present?

    @categories = @categories.paginate(page: params[:page], per_page: 12)
  end

  def new
    @category = Category.new
  end

  def edit
    @category = Category.find(params[:id])
    render :new
  end
  
  def update
    @category = Category.find(params[:id])
    @category.attributes = category_params
    if @category.save
      redirect_to categories_path
    end
  end
  
  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to categories_path
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to categories_path
  end

  private
    def category_params
      params.require(:category).permit(:id, :name)
    end

    def check_permissions
      redirect_to posts_path and return if current_user.is_normal?
    end
end
