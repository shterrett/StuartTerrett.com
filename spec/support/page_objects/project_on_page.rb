class ProjectOnPage < PageObject::Base
  attr_reader :technologies

  def initialize(project = nil)
    @project = project
    @technologies = []
  end

  def add_technology(technology)
    @technologies << technology
    @project.technologies << technology
  end

  def create(&block)
    http_login
    visit new_project_path
    fill_in_form &block
    click_button 'Create Project'
    @project = Project.last
  end

  def edit(&block)
    http_login
    visit edit_project_path(@project)
    fill_in_form &block
    click_button 'Update Project'
  end

  def view_projects
    visit projects_path
  end

  def view_project
    visit project_path(@project)
  end

  def has_name?(value)
    has_text? value
  end

  def has_description?(value)
    has_text? value
  end

  def has_short_description?(value)
    has_text? value
  end

  def has_source_link?
    page.html.include? @project.source_link
  end

  def has_technologies?(technologies)
    technologies.each do |technology|
      has_text? technology.name
    end
  end

  def has_associated_technologies_on_edit?
    http_login
    visit edit_project_path(@project)
    technologies = @project.technologies.map { |tech| tech.slice(:id, :name) }
    has_css?("[data-load ='#{technologies.to_json}']")
  end

  private

  def fill_in_form(&block)
    ProjectForm.new(&block)
  end
end
