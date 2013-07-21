class ProjectsController < ApplicationController

  http_basic_authenticate_with name: Auth.username, password: Auth.password, except: [:show, :index]

  def new
    @project = Project.new
    @technologies = Technology.all
  end
  
  def create
    @project = Project.new(project_params)
    if @project.save
      create_project_techs(@project, params[:project][:technologies])
      flash[:success] = "Project created successfully"
      redirect_to new_project_path
    else
      flash[:error] = "There was an error creating the project"
      render 'new'
    end
  end
  
  def show
    @project = Project.find(params[:id])
    @technologies = @project.technologies
  end
  
  def edit
    @project = Project.find(params[:id])
    @project_technology_ids = @project.technologies.pluck(:id)
    @technologies = Technology.all
  end
  
  def update
    @project = Project.find(params[:id])
    if @project.update_attributes(project_params)
      update_project_techs(@project, params[:project][:technologies])
      flash[:success] = "Project updated successfully"
      redirect_to project_path(@project)
    else
      flash[:error] = "There was an error updating the project"
      render 'edit'
    end
  end
  
  def index
    @projects = Project.all
    @technologies = Technology.all
  end
  
  def project_params
    params.require(:project).permit(:name, :description, :short_description, :technologies)
  end
  
  def create_project_techs(project, technologies)
    technologies.each do |id|
      ProjectTech.create({ project_id: project.id, technology_id: id }) unless id.empty?
    end
  end
  
  def update_project_techs(project, technologies)
    existing_ids = ProjectTech.where(project_id: project.id).pluck(:technology_id)
    to_delete = existing_ids - technologies
    to_create = technologies - existing_ids
    create_project_techs(project, to_create)
    ProjectTech.where(project_id: project.id, technology_id: to_delete).destroy_all
  end
  
end
