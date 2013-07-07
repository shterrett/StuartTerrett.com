class EmploymentsController < ApplicationController
  
  def new
    @employment = Employment.new
    @technologies = Technology.all
    @projects = Project.all
  end
  
  def create
    @employment = Employment.new(employment_params)
    if @employment.save
      create_employment_techs(@employment, params[:employment][:technologies])
      associate_projects(@employment, params[:employment][:projects])
      flash[:success] = "Employment created successfully"
      redirect_to new_employment_path
    else
      flash[:error] = "There was a problem creating the employment"
      render 'new'
    end
  end
  
  def edit
    @employment = Employment.find(params[:id])
    @technologies = Technology.all
    @projects = Project.all
    @employment_project_ids = @employment.projects.pluck(:id)
    @employment_technology_ids = @employment.technologies.pluck(:id)
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
    params.require(:employment).permit(:company, :position, :description, :start_date, :end_date, :url, :technologies, :projects)
  end
  
  def create_employment_techs(employment, technologies)
    technologies.each do |id|
      EmploymentTech.create({ employment_id: employment.id, technology_id: id }) unless id.empty?
    end
  end
  
  def associate_projects(employment, project_ids)
    projects = Project.where(id: project_ids)
    employment.projects << projects
  end
  
end
