class TechnologiesController < ApplicationController

  def show
    @technology = Technology.find(params[:id])
    @projects = @technology.projects
  end

  def index
    @technologies = Technology.all
  end

  def tokens
    @technologies = Technology.where('abbreviation like ?', "%#{params[:q]}%")
    respond_to do |format|
      format.json { render json: @technologies.map { |project| project.attributes.slice('id', 'name') } }
    end
  end
end
