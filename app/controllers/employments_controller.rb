class EmploymentsController < ApplicationController
  def index
    @employments = Employment.all
  end

  def show
    @employment = Employment.find(params[:id])
    @projects = @employment.projects
    @technologies = @employment.technologies
  end
end
