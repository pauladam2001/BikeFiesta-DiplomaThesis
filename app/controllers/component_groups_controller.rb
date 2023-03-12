class ComponentGroupsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!, :check_permissions
  
  def index
    @components = ComponentGroup.order('name ASC')

    @components = @components.where("name ilike ?", "%#{params[:name]}%") if params[:name].present?

    @components = @components.paginate(page: params[:page], per_page: 12)
  end

  def new
    @component = ComponentGroup.new
  end

  def edit
    @component = ComponentGroup.find(params[:id])
    render :new
  end
  
  def update
    @component = ComponentGroup.find(params[:id])
    @component.with_lock do
    @component.attributes = component_group_params
      if @component.save
        redirect_to component_groups_path, alert: "Component #{@component.name} updated successfully."
      else
        redirect_back(fallback_location: component_groups_path, alert: "Error - #{@component.errors.full_messages.first}.")
      end
    end
  end
  
  def create
    @component = ComponentGroup.new(component_group_params)
    if @component.save
      redirect_to component_groups_path, alert: "Component #{@component.name} created successfully."
    else
      redirect_back(fallback_location: component_groups_path, alert: "Error - #{@component.errors.full_messages.first}.")
    end
  end

  def destroy
    @component = ComponentGroup.find(params[:id])
    @component.destroy
    redirect_back(fallback_location: component_groups_path, alert: "Component deleted successfully.")
  end

  private
    def component_group_params
      params.require(:component_group).permit(:id, :name)
    end

    def check_permissions
      redirect_to posts_path and return if current_user.is_normal?
    end
end
