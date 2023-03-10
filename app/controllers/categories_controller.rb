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
    @category.with_lock do
      @category.attributes = category_params
      if @category.save
        redirect_to categories_path, alert: "Category #{@category.name} updated successfully."
      else
        redirect_back(fallback_location: categories_path, alert: "Error - #{@category.errors.full_messages.first}.")
      end
    end
  end
  
  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to categories_path, alert: "Category #{@category.name} created successfully."
    else
      redirect_back(fallback_location: categories_path, alert: "Error - #{@category.errors.full_messages.first}.")
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_back(fallback_location: categories_path, alert: "Category deleted successfully.")
  end

  private
    def category_params
      params.require(:category).permit(:id, :name)
    end

    def check_permissions
      redirect_to posts_path and return if current_user.is_normal?
    end
end
