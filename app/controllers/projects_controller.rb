class ProjectsController < ApplicationController

  http_basic_authenticate_with name: Auth.username, password: Auth.password, except: [:show, :index]

  def new
    @project = Project.new
    @technologies = Technology.all
  end

  def create
    @project = Project.new(project_params.except(:technologies))
    if @project.save
      flash[:success] = "Project created successfully"
      redirect_to new_project_path
    else
      flash[:error] = "There was an error creating the project"
      @project_technology_ids = params[:project][:technologies]
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
    @project.valid?
    if @project.update_attributes(project_params)
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

  def tokens
    @projects = Project.where("name like ?", "%#{params[:q]}%")
    respond_to do |format|
      format.json { render json: @projects.map { |project| project.attributes.slice("id", "name") } }
    end
  end

  def project_params
    params.require(:project).permit(:name, :description, :short_description, :source, :technology_tokens)
  end

end
