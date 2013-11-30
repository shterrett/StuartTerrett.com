class TechnologyOnPage < PageObject::Base
  def initialize(technology = nil)
    @technology = technology
  end

  def create(&block)
    http_login
    visit new_admin_technology_path
    fill_in_form(&block)
    click_button 'Create Technology'
    @technology = Technology.last
  end

  def edit(&block)
    http_login
    visit edit_admin_technology_path @technology
    fill_in_form(&block)
    click_button 'Update Technology'
  end

  def view_technologies
    visit technologies_path
  end

  def view_technology
    visit technology_path @technology
  end

  def has_name?(value)
    has_text? value
  end

  def has_description?(value)
    has_text? value
  end

  def has_project?(project)
    has_text? project.name
  end

  private

  def fill_in_form(&block)
    TechnologyForm.new(&block)
  end
end
