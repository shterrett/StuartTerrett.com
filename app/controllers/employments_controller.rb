class EmploymentsController < ApplicationController
  
  def new
    @employment = Employment.new
  end
  
  def create
    @employment = Employment.new(employment_params)
    if @employment.save
      flash[:success] = "Employment created successfully"
      redirect_to new_employment_path
    else
      flash[:error] = "There was a problem creating the employment"
      render 'new'
    end
  end
  
  def edit
    @employment = Employment.find(params[:id])
  end
  
  def update
    @employment = Employment.find(params[:id])
    if @employment.update_attributes(employment_params)
      flash[:success] = "Employment updated successfully"
      redirect_to resume_path
    else
      flash[:error] = "There was a problem creating the employment"
      render 'edit'
    end
  end
  
  def show
    @employment = Employment.find(params[:id])
    @projects = @employment.projects
    @technologies = @employment.technologies
  end
  
  def index
    @employments = Employment.all
  end
  
  def employment_params
    params.require(:employment).permit(:company, :position, :description, :start_date, :end_date, :url)
  end
  
end
