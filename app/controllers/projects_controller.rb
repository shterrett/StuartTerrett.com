class ProjectsController < ApplicationController
  def show
    @project = Project.find(params[:id])
    @technologies = @project.technologies
  end

  def index
    @projects = Project.all
    @technologies = Technology.all
  end

  def tokens
    @projects = Project.where('name like ?', "%#{params[:q]}%")
    respond_to do |format|
      format.json { render json: @projects.map { |project| project.attributes.slice('id', 'name') } }
    end
  end
end
