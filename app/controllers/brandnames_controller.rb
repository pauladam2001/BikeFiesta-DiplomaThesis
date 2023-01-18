class BrandnamesController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @brand_names = Brandname.order('name ASC')
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
    @brand_name.attributes = brandname_params
    if @brand_name.save
      redirect_to brandnames_path
    end
  end
  
  def create
    @brand_name = Brandname.new(brandname_params)
    if @brand_name.save
      redirect_to brandnames_path
    end
  end

  def destroy
    @brand_name = Brandname.find(params[:id])
    @brand_name.destroy
    redirect_to brandnames_path
  end

  def brandname_params
    params.require(:brandname).permit(:id, :name)
  end
end
