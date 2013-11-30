class Admin::AboutsController < AdminsController
  def edit
    @about = About.find_or_create_by(id: 1)
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

  private

  def about_params
    params.require(:about).permit(:info)
  end
end
