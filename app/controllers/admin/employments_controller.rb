class Admin::EmploymentsController < AdminsController
  def index
    @employments = Employment.all
  end

  def new
    @employment = Employment.new
    @technologies = Technology.all
    @projects = Project.all
  end

  def create
    @employment = Employment.new(employment_params.except(:technologies, :projects))
    if @employment.save
      flash[:success] = 'Employment created successfully'
      redirect_to new_admin_employment_path
    else
      flash[:error] = 'There was a problem creating the employment'
      render 'new'
    end
  end

  def edit
    @employment = Employment.find(params[:id])
    @technologies = Technology.all
    @projects = Project.all
    @employment_project_ids = @employment.projects.pluck(:id)
    @employment_technology_ids = @employment.technologies.pluck(:id)
  end

  def update
    @employment = Employment.find(params[:id])
    if @employment.update_attributes(employment_params.except(:technologies, :projects))
      flash[:success] = 'Employment updated successfully'
      redirect_to resume_path
    else
      flash[:error] = 'There was a problem creating the employment'
      render 'edit'
    end
  end

  private

  def employment_params
    params.require(:employment).permit(:company, :position, :description, :start_date, :end_date, :url, :technology_tokens, :project_tokens)
  end
end
