class AdminController < ApplicationController

  http_basic_authenticate_with name: Auth.username, password: Auth.password, except: :show

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
