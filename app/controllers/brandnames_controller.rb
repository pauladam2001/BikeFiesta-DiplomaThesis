class BrandnamesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!, :check_permissions
  
  def index
    @brand_names = Brandname.order('name ASC')

    @brand_names = @brand_names.where("name ilike ?", "%#{params[:name]}%") if params[:name].present?

    @brand_names = @brand_names.paginate(page: params[:page], per_page: 12)
  end

  def new
    @brand_name = Brandname.new
  end

  def edit
    @brand_name = Brandname.find(params[:id])
    render :new
  end
  
  def update
    @brand_name = Brandname.find(params[:id])
    @brand_name.with_lock do
      @brand_name.attributes = brandname_params
      if @brand_name.save
        redirect_to brandnames_path, alert: "Brand #{@brand_name.name} updated successfully."
      else
        redirect_back(fallback_location: brandnames_path, alert: "Error - #{@brand_name.errors.full_messages.first}.")
      end
    end
  end
  
  def create
    @brand_name = Brandname.new(brandname_params)
    if @brand_name.save
      redirect_to brandnames_path, alert: "Brand #{@brand_name.name} created successfully."
    else
      redirect_back(fallback_location: brandnames_path, alert: "Error - #{@brand_name.errors.full_messages.first}.")
    end
  end

  def destroy
    @brand_name = Brandname.find(params[:id])
    @brand_name.destroy
    redirect_back(fallback_location: brandnames_path, alert: "Brand deleted successfully.")
  end

  private
    def brandname_params
      params.require(:brandname).permit(:id, :name)
    end

    def check_permissions
      redirect_to posts_path and return if current_user.is_normal?
    end
end
