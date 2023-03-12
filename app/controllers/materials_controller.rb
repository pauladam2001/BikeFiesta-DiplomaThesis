class MaterialsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!, :check_permissions
  
  def index
    @materials = Material.order('name ASC')

    @materials = @materials.where("name ilike ?", "%#{params[:name]}%") if params[:name].present?

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
    @material.with_lock do
      @material.attributes = material_params
      if @material.save
        redirect_to materials_path, alert: "Material #{@material.name} updated successfully."
      else
        redirect_back(fallback_location: materials_path, alert: "Error - #{@material.errors.full_messages.first}.")
      end
    end
  end
  
  def create
    @material = Material.new(material_params)
    if @material.save
      redirect_to materials_path, alert: "Material #{@material.name} created successfully."
    else
      redirect_back(fallback_location: materials_path, alert: "Error - #{@material.errors.full_messages.first}.")
    end
  end

  def destroy
    @material = Material.find(params[:id])
    @material.destroy
    redirect_back(fallback_location: materials_path, alert: "Material deleted successfully.")
  end

  private
    def material_params
      params.require(:material).permit(:id, :name)
    end

    def check_permissions
      redirect_to posts_path and return if current_user.is_normal?
    end
end
