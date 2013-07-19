class AdminController < ApplicationController
  
  def admin
  end
  
  def technologies_index
    @technologies = Technology.all
  end
  
  def projects_index
    @projects = Project.all
  end
  
  def employments_index
    @employments = Employment.all
  end
  
end
