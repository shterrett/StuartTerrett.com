class Admin::TechnologiesController < AdminsController
  def index
    @technologies = Technology.all
  end

  def new
    @technology = Technology.new
  end

  def create
    @technology = Technology.new(tech_params)
    if @technology.save
      flash[:success] = 'Technology created successfully'
      redirect_to new_admin_technology_path
    else
      flash[:error] = 'There was an error creating the technology'
      render 'new'
    end
  end

  def edit
    @technology = Technology.find(params[:id])
  end

  def update
    @technology = Technology.find(params[:id])
    if @technology.update_attributes(tech_params)
      flash[:success] = "Technology updated successfully"
      redirect_to admin_technologies_path
    else
      flash[:error] = 'There was an error updating the technology'
      render 'edit'
    end
  end

  private

  def tech_params
    params.require(:technology).permit(:name, :abbreviation, :description)
  end
end
