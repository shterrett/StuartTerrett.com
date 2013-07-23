class TechnologiesController < ApplicationController
  
  http_basic_authenticate_with name: Auth.username, password: Auth.password, except: [:show, :index]

  def new
    @technology = Technology.new
  end
  
  def create
    @technology = Technology.new(tech_params)
    if @technology.save
      flash[:success] = "Technology created successfully"
      redirect_to new_technology_path
    else
      flash[:error] = "There was an error creating the technology"
      render 'new'
    end
  end
  
  def show
    @technology = Technology.find(params[:id])
    @projects = @technology.projects
  end
  
  def edit
    @technology = Technology.find(params[:id])
  end
  
  def update
    @technology = Technology.find(params[:id])
    if @technology.update_attributes(tech_params)
      flash[:success] = "Technology updated successfully"
      redirect_to technologies_path
    else
      flash[:error] = "There was an error updating the technology"
      render 'edit'
    end
  end
  
  def index
    @technologies = Technology.all
  end
  
  def tech_params
    params.require(:technology).permit(:name, :abbreviation, :description)
  end
  
end
