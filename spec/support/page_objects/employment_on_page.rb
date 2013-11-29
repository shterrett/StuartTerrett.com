class EmploymentOnPage < PageObject::Base
  include ApplicationHelper

  def initialize(employment = nil)
    @employment = employment
  end

  def view_employment
    visit employment_path(@employment)
  end

  def view_resume
    visit '/resume'
  end

  def create(&block)
    http_login
    visit new_employment_path
    fill_in_form &block
    click_button 'Create Employment'
    @employment = Employment.last
  end

  def edit(&block)
    http_login
    visit edit_employment_path(@employment)
    fill_in_form &block
    click_button 'Update Employment'
  end

  def has_success_message?(action)
    has_text? "Employment #{action}d successfully"
  end

  def has_description?(description)
    page.html.include? render_markdown(description)
  end

  def has_position?(position)
    has_text? position
  end

  def has_company?(company)
    has_text? company
  end

  def has_url?(url)
    has_text? url
  end

  def has_start_date?
    has_text? @employment.format_date(:start_date)
  end

  def has_end_date?
    has_text? @employment.format_date(:end_date)
  end

  def has_technologies?(technologies)
    @employment.technologies = technologies
  end

  def has_technologies_on_page?(technologies)
    technologies.each do |technology|
      has_text? technology.name
    end
  end

  def has_projects?(projects)
    @employment.projects = projects
  end

  def has_projects_on_page?(projects)
    projects.each do |project|
      has_text? project.name
    end
  end

  private

  def fill_in_form(&block)
    EmploymentForm.new(&block)
  end
end
