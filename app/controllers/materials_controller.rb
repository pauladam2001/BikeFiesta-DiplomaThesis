class MaterialsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!, :check_permissions
  
  def index
    @materials = Material.order('name ASC')
    @materials = @materials.paginate(page: params[:page], per_page: 12)
  end

  def new
    @material = Material.new
  end

  def edit
    @material = Material.find(params[:id])
    render :new
  end
  
  def update
    @material = Material.find(params[:id])
    @material.attributes = material_params
    if @material.save
      redirect_to materials_path
    end
  end
  
  def create
    @material = Material.new(material_params)
    if @material.save
      redirect_to materials_path
    end
  end

  def destroy
    @material = Material.find(params[:id])
    @material.destroy
    redirect_to materials_path
  end

  private
    def material_params
      params.require(:material).permit(:id, :name)
    end

    def check_permissions
      redirect_to posts_path and return if current_user.is_normal?
    end
end
