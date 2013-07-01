class ProjectsController < ApplicationController
  
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
  end
  
  def edit
    @project = Project.find(params[:id])
    @technologies = Technology.all
  end
  
  def update
    @project = Project.find(params[:id])
    if @project.update_attributes(project_params)
      flash[:success] = "Project updated successfully"
      redirect_to project_path(@project)
    else
      flash[:error] = "There was an error updating the project"
      render 'edit'
    end
  end
  
  def project_params
    params.require(:project).permit(:name, :description, :short_description, :technologies)
  end
  
  def create_project_techs(project, technologies)
    technologies.each do |id|
      ProjectTech.create({ project_id: project.id, technology_id: id })
    end
  end
  
end
