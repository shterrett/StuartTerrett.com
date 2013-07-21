class AboutsController < ApplicationController
  # before_action :authenticate, except: :show

  http_basic_authenticate_with name: Auth.username, password: Auth.password, except: :show

  def edit
    @about = About.find(1)
  end
  
  def update
    @about = About.find(1)
    if @about.update_attributes(about_params)
      flash[:success] = "About Me updated successfully"
      redirect_to about_me_path
    else
      flash[:error] = "There was a problem updating About Me"
      render 'edit'
    end
  end
  
  def show
    @about = About.find(1)
  end
  
  def about_params
    params.require(:about).permit(:info)
  end
  
end
